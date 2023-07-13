class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.51.1'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.51.1/mkr_darwin_arm64.zip'
    sha256 'd4bf59b8af929cd1acebf1c8a424ad76c92ffbc63219cfaced42411189dc6f88'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.51.1/mkr_darwin_amd64.zip'
    sha256 'f7b9c1d7702a4408c311af333a6bc802fd2a09cc4a1bdb97230e20cdd0abef57'
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
