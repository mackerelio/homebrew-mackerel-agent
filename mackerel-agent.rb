class MackerelAgent < Formula
  homepage 'https://github.com/mackerelio/mackerel-agent'
  version '0.74.1'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.74.1/mackerel-agent_darwin_arm64.zip'
    sha256 '8337e6544e6e43b7035c9ed4d5789853da1c587869c78319274a69b4ffe7d4ed'
  else
    url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.74.1/mackerel-agent_darwin_amd64.zip'
    sha256 '09d210ba40aaf92733e6f4fe694cdba2e11b689ceab9d13b306152f1e8062d4a'
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

  plist_options :manual => "mackerel-agent -conf #{HOMEBREW_PREFIX}/etc/mackerel-agent.conf"

  def plist; <<~EOS
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
     <key>KeepAlive</key>
     <true/>
     <key>Label</key>
     <string>#{plist_name}</string>
     <key>ProgramArguments</key>
     <array>
         <string>#{opt_bin}/mackerel-agent</string>
         <string>supervise</string>
         <string>-conf</string>
         <string>#{etc}/mackerel-agent.conf</string>
         <string>-private-autoshutdown</string>
     </array>
     <key>RunAtLoad</key>
     <true/>
     <key>WorkingDirectory</key>
     <string>#{var}/mackerel-agent</string>
     <key>StandardErrorPath</key>
     <string>#{var}/log/mackerel-agent.log</string>
   </dict>
   </plist>
   EOS
  end

  def caveats; <<~EOS
    You must append `apikey = {apikey}` configuration variable to #{etc}/mackerel-agent.conf
    in order for mackerel-agent to work.
    EOS
  end
end
