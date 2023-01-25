class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.48.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.48.0/mkr_darwin_arm64.zip'
    sha256 '660989fa17f0c9246a55ad1d3901c3549ccea899210a24b79387f60ae144e4fe'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.48.0/mkr_darwin_amd64.zip'
    sha256 'd392e0b8f826d85d05bb9f076053848e3e95baf4a48cfdfe11c1e1c368b7288d'
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
