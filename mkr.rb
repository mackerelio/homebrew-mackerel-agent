class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.47.2'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.47.2/mkr_darwin_arm64.zip'
    sha256 '5650412d12ee9527c1a2a883847ea6d78d0844e8bfd3154809e981812edf905d'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.47.2/mkr_darwin_amd64.zip'
    sha256 '14ebc47cf5fd78a6231b2265eb3ca1c7c7b4244256ecd57dade7d689b2489fd5'
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
