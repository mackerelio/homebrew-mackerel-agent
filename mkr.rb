class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.40.1'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.40.1/mkr_darwin_amd64.zip'
  sha256 '0c39d74e78cc3c2f4473e7ac1616c7cf9fa3b503122cf3075818091e36e441c9'

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
