class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.45.1'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.45.1/mkr_darwin_amd64.zip'
  sha256 '4098e08f8fcd410c3886dda0881af19ef581bd1057109290b4ed9403697f05bd'

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
