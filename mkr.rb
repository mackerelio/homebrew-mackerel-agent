class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.36.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.36.0/mkr_darwin_amd64.zip'
    sha256 '6bbf3322594e55fa48376d1d08a9774685215d7f8a6fee1060cf468a2c395588'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.36.0/mkr_darwin_386.zip'
    sha256 'c962344a72d3705960a1bc8a06c4d1e9fef63b555bf24665238022cabbdc32fb'
  end

  head do
    url 'https://github.com/mackerelio/mkr.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/mackerelio'
      ln_s buildpath, buildpath/'.go/src/github.com/mackerelio/mkr'
      system 'make', 'build'
      bin.install 'mkr'
    else
      bin.install 'mkr'
    end
  end

  test do
    system 'mkr', '--version'
  end
end
