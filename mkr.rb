class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.30.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.30.0/mkr_darwin_amd64.zip'
    sha256 'a836507f62b7c35891a24124d7b6b993c7c479b1b785b1276bdf8036d6277649'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.30.0/mkr_darwin_386.zip'
    sha256 'b7d6af465b58ff0f23ad9b0c7d64b60cc2392bf18bf88df4839ead981d51a16c'
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
