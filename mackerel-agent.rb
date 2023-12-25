class MackerelAgent < Formula
  homepage 'https://github.com/mackerelio/mackerel-agent'
  version '0.78.3'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.78.3/mackerel-agent_darwin_arm64.zip'
    sha256 '9a8361f7335f6075ba1db58b367b63492d493c86b63a0cfbd99cfcc9f34db7f5'
  else
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.78.3/mackerel-agent_darwin_amd64.zip'
    sha256 'f5bf73c13472582a4f009940dc6cf34ed84e6ed6972d044f5058bc3e2fa068ea'
  end

  head do
    url 'https://github.com/mackerelio/mackerel-agent.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
      system 'make', 'build'
      bin.install 'build/mackerel-agent'
      etc.install 'mackerel-agent.sample.conf' => 'mackerel-agent.conf'
    else
      bin.install 'mackerel-agent'
      etc.install 'mackerel-agent.conf'
    end
    mkdir_p "#{var}/mackerel-agent"
  end

  test do
    system 'mackerel-agent', 'version'
  end

  service do
    run ["#{opt_bin}/mackerel-agent", 'supervise', '-conf', "#{etc}/mackerel-agent.conf", '-private-autoshutdown']
    keep_alive true
    working_dir "#{var}/mackerel-agent"
    error_log_path "#{var}/log/mackerel-agent.log"
  end

  def caveats; <<~EOS
    You must append `apikey = {apikey}` configuration variable to #{etc}/mackerel-agent.conf
    in order for mackerel-agent to work.
    EOS
  end
end
