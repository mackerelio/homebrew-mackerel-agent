class MackerelAgent < Formula
  homepage 'https://github.com/mackerelio/mackerel-agent'
  version '0.84.3'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.84.3/mackerel-agent_darwin_arm64.zip'
    sha256 '0bea25cb5b11d5bc6ba3dba02821fd680d28228349f9572003882f474ac38800'
  else
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.84.3/mackerel-agent_darwin_amd64.zip'
    sha256 'dd2a3e114386b22b3bbdf4a448374268bb49aebef4ac0bfbffa2efd4b798632f'
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
