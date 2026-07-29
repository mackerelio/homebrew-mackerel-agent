class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.65.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.65.0/mkr_darwin_arm64.zip'
    sha256 '91889dea4a569e67ffc83dc3618b2a7d65a493b9aebb034e0c723c4a4a7999a6'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.65.0/mkr_darwin_amd64.zip'
    sha256 'bdb18a929293ed78c16c14f6bd1d0efe6c9e8bc737f2989f049437aceb82c74f'
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
