class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.62.2'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.62.2/mkr_darwin_arm64.zip'
    sha256 'eb8b328f4f936a6138804d4cffdb6f0136a260883ebae3c0bbb0d415b7e7fc20'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.62.2/mkr_darwin_amd64.zip'
    sha256 '948aeedea29be310db75b487c7e48647363520e03317393b25f5ea8d1b70438a'
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
