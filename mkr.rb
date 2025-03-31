class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.60.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.60.0/mkr_darwin_arm64.zip'
    sha256 '5341816e57f8718be74f8c5e59fea0227a17e08db865e068d10943b7434742d2'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.60.0/mkr_darwin_amd64.zip'
    sha256 'd257fbcaf5d1890698bd4f7dec06ef3ea1aed3581a9a15f536d300ad9f0d3f48'
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
