class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.49.2'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.2/mkr_darwin_arm64.zip'
    sha256 '768d96a3ee6d0e33d3ff751c5c74ab76a472ce0fecd8ccefe2c4438ace7e7596'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.2/mkr_darwin_amd64.zip'
    sha256 '4189176c0a583a06b8c8d207c22480b285695216559468cf2147cb19a984f015'
  end

  head do
    url 'https://github.com/mackerelio/mkr.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
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
