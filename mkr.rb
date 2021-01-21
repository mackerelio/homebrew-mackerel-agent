class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.43.1'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.43.1/mkr_darwin_amd64.zip'
  sha256 '00d35d2c74dfcce6a146a535143b944d2d0b4643cae7320983d96a094cd78a86'

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
