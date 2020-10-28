class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.41.0'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.41.0/mkr_darwin_amd64.zip'
  sha256 '19e4a1911beafeda74b97baaf590804dee2054132e4b60e6ecb4011c679f924a'

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
