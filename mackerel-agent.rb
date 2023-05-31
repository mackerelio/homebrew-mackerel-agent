class MackerelAgent < Formula
  homepage 'https://github.com/mackerelio/mackerel-agent'
  version '0.76.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.76.0/mackerel-agent_darwin_arm64.zip'
    sha256 '434980e0ff1012612810351fc7fa3cd75c8d911a5846d98c95e63d9b647aab0d'
  else
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.76.0/mackerel-agent_darwin_amd64.zip'
    sha256 '8d910c4144d68445985874efe33e11e441d3f4d15c71f5c6818c9a82419a7e97'
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
