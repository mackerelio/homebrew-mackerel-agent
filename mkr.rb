class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.16.1'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.16.1/mkr_darwin_amd64.zip'
    sha256 '1dd5b2343819658d22781634e12b15b26d6dbf65e1a529cec47a6219d676ecf8'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.16.1/mkr_darwin_386.zip'
    sha256 'ba206b86fac9045ea7565ec21c0fc5204bcc3dc496c57bb2b444830a6d4fb6c8'
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
