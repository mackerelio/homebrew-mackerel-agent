class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.13.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.13.0/mkr_darwin_amd64.zip'
    sha256 'ccedc41758289be519fd65ed50564a4c97a4f2e7a6b336cb757ac4572e709dfa'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.13.0/mkr_darwin_386.zip'
    sha256 'bc483cc5065f9120a7d6578123ddeac30da803e9e782654130d0d6a92f6c3f10'
  end

  head do
    url 'https://github.com/mackerelio/mkr.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/mackerelio'
      ln_s buildpath, buildpath/'.go/src/github.com/mackerelio/mkr'
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
