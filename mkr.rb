class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.39.5'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.39.5/mkr_darwin_amd64.zip'
  sha256 'f6507bdef76f650c3810544b2bbc7df7ce31651e1186b98da0b2a05e1224b769'

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
