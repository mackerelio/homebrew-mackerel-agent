class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.49.3'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.3/mkr_darwin_arm64.zip'
    sha256 '646ddac433c39ac45c259ecaf15318fd7e0add75f51b37e4eebfa0d9248b47b8'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.3/mkr_darwin_amd64.zip'
    sha256 '113b4af56d09bc8eafe1ed7faa352d9febad1528aa41af8cd07cd75d306ba281'
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
