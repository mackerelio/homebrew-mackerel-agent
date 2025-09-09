class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.62.1'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.62.1/mkr_darwin_arm64.zip'
    sha256 '7a744f52de5b16b48ea31cc6df19a3aa44476f510b0be095f48c84874797d40f'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.62.1/mkr_darwin_amd64.zip'
    sha256 'd16327bd756f81299d88d21de2258997bb8ab66fc66e7d2e0e918bf8197ef81d'
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
