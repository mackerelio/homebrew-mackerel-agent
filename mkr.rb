class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.39.7'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.39.7/mkr_darwin_amd64.zip'
  sha256 '9aea62db3717f2e0728dd88d1ee7076a47db6847627b4a60c174882348b5da8a'

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
