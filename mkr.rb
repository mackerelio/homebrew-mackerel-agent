class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.57.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.57.0/mkr_darwin_arm64.zip'
    sha256 '91ec86adb9533da51f48837b8181ea996e3764e5d904c51c899e42b985fa4cf7'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.57.0/mkr_darwin_amd64.zip'
    sha256 '556e9de7ee22f688140f49976b3c06ef610e9705285bd58f8fbc0f4cf9810f17'
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
