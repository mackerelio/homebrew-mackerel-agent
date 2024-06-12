class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.58.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.58.0/mkr_darwin_arm64.zip'
    sha256 '86152416fe79ec127711f00e32039989afbda691c03c5350704225172fae1fa4'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.58.0/mkr_darwin_amd64.zip'
    sha256 '1e8d106fc17a3e7e3c34b2249c67ea6754d044bf403d7551ea507ba3bed08af2'
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
