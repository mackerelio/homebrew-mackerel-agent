class MackerelAgent < Formula
  homepage 'https://github.com/mackerelio/mackerel-agent'
  version '0.85.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.85.0/mackerel-agent_darwin_arm64.zip'
    sha256 '4e1a43bfce84bb6b8ef8e661afbfa8398c52d0237cb8545b54835e66f4aaba95'
  else
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.85.0/mackerel-agent_darwin_amd64.zip'
    sha256 'a138d84e823616c451b5c0335f1b64159c712324ae15c93bda86b24c0cba1606'
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
