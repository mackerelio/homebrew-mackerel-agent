#! /usr/bin/env ruby

require "rubygems/version"
require "open-uri"
require "openssl"
require 'json'

class Formula
  BASE_DIR = File.dirname(File.expand_path("../", __FILE__)).freeze

  VERSION_REGEXP = /^(\s*)version\s'([^']+)'$/i.freeze
  URL_REGEXP     = /\A(\s*)url '([^']+)'\z/.freeze
  DIGEST_REGEXP  = /\A(\s*)sha256 '([a-fA-F0-9]+)'\z/.freeze

  VERSION_TAG_REGEXP = /\Av((\d+)\.(\d+)\.(\d+))\z/.freeze

  attr_reader :name, :version, :path

  def initialize(name)
    @owner = "mackerelio" # hard-coded
    @name = name
    @path = File.join(BASE_DIR, "#{name}.rb")
    raise "no such Formula" unless File.exist?(@path)
    @body = File.read(self.path)
    parse_version
  end

  def update(next_version)
    unless next_version.is_a?(Gem::Version)
      raise "invalid next version"
    end
    unless self.version < next_version
      raise "%s is smaller than %s" % [next_version, self.version]
    end

    puts "[UPDATE] version"
    update_version! next_version
    puts "[UPDATE] url"
    update_file_urls! next_version
    puts "[UPDATE] digest"
    update_digets!
  end

  def save
    File.open(self.path, "wb") do |io|
      io.puts @body
    end
  end

  def find_latest_version
    api_url = "https://api.github.com/repos/#{@owner}/#{@name}/releases/latest"
    parsed = JSON.parse(open(api_url).read)
    # remove `v` prefix
    VERSION_TAG_REGEXP.match(parsed["name"]).to_a[1]
  end

  private
  def parse_version
    match = VERSION_REGEXP.match(@body)
    raise "can not parse version" if match.nil?
    unless Gem::Version.correct?(match[2])
      raise "invalid current version"
    end
    @version = Gem::Version.create(match[2])
  end

  def update_version!(next_version)
    puts "  ----> #{self.version} → #{next_version}"
    replace @body, VERSION_REGEXP do |m|
      "#{m[1]}version '#{next_version}'"
    end
  end

  def update_file_urls!(next_version)
    replaced = @body.split("\n").map do |line|
      if URL_REGEXP =~ line
        replace line, URL_REGEXP do |m|
          new_url = m[2].sub(/\/v\d+\.\d+\.\d+\//, "/v#{next_version}/")
          puts "  ----> #{m[2]} → #{new_url}"
          "#{m[1]}url '#{new_url}'"
        end
      end
      line
    end
    @body = replaced.join("\n")
  end

  def update_digets!
    lines = @body.split("\n")
    index = 0
    while index < lines.length
      line = lines[index]
      if match = URL_REGEXP.match(line)
        index += 1
        digest_line = lines[index]

        DIGEST_REGEXP.match(digest_line) do
          url = match[2]
          print "  <---- download: #{url} ..."
          digest = OpenSSL::Digest::SHA256.hexdigest(open(url).read)
          puts "done"
          replace digest_line, DIGEST_REGEXP do |m|
            puts "  ----> #{m[2]} → #{digest}"
            "#{m[1]}sha256 '#{digest}'"
          end
          lines[index] = digest_line
        end
      end
      index += 1
    end
    @body = lines.join("\n")
  end

  def replace(body, regexp, word = nil)
    regexp.match(body) do |match|
      word = yield(match) if block_given?
      body.sub!(regexp, word)
    end
  end
end

def error(message)
  abort "ERROR: #{message}"
end

def main(args)
  name = args[0].downcase

  formula = Formula.new(name)

  if args[1] == "latest"
    version_str = formula.find_latest_version
  else
    version_str = args[1]
  end

  unless Gem::Version.correct?(version_str)
    abort "invalid version"
  end
  next_version = Gem::Version.create(version_str)

  begin
    formula.update(next_version)
  rescue => e
    error e.message
  end
  formula.save

  puts

  system "git", "add", formula.path
  system "git", "diff", "--cached"

  puts
  puts "[NEXT]"
  puts "brew uninstall --force #{formula.name}"
  puts "brew install ./#{formula.name}.rb"
end

if $0 == __FILE__
  if ARGV.length != 2
    abort "USAGE: ruby tools/update.rb FORMULA_NAME VERSION"
  end

  main ARGV
end
