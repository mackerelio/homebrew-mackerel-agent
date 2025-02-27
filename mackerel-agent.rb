class MackerelAgent < Formula
  homepage 'https://github.com/mackerelio/mackerel-agent'
  version '0.84.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.84.0/mackerel-agent_darwin_arm64.zip'
    sha256 '4ce8ce1f79270ef110a64864b293f6d94eea666430aed3d53b5a99e443632848'
  else
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.84.0/mackerel-agent_darwin_amd64.zip'
    sha256 '514aa6672a3b3e748f1b0c1dfca5c43460ea7f7b2a68c2a6f0daf5624fd6a529'
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
