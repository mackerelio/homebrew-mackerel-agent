class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.67.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.67.0/mkr_darwin_arm64.zip'
    sha256 '1d8d7ce96fce5a474f007d22f6a58b43b195ebf9a304897614a51f0e6f59cf70'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.67.0/mkr_darwin_amd64.zip'
    sha256 '5381df9ee7627755ba49d0e94178c2365ce25704802b3ab387f29e100d8238df'
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
