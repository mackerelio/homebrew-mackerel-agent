class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.63.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.63.0/mkr_darwin_arm64.zip'
    sha256 '6992301a403252b238f9bd6c0b8c9e1337c1f985367f0e9b9740044ede3b037a'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.63.0/mkr_darwin_amd64.zip'
    sha256 'fdee5e59e31f3cfdd4629150e5b726536603eb91aa72e3f9e6d0b9f5f00468ef'
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
