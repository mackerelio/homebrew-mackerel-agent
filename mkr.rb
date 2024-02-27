class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.55.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.55.0/mkr_darwin_arm64.zip'
    sha256 'c4a221193434eb132c3e90be1133e7dcbab85b150d63be770d81e3f8849753bb'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.55.0/mkr_darwin_amd64.zip'
    sha256 'cbb6c0117b1e8e5ccf2789ca61e926f28cfd2ac1d0ffc92f8d3184834d84b8f9'
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
