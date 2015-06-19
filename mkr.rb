class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.1.0'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.1.0/mkr_darwin_amd64.zip'
    sha256 '4ea0252b2f73ebbf8b5ca20844c7fbf088edd6ec00defb5bde1d26f4d88d022c'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.1.0/mkr_darwin_386.zip'
    sha256 'ac8bbc889c802dcb61a968975641a005a76a27b078b8bc4bb1859e17f2017ac8'
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
