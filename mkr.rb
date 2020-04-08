class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.40.0'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.40.0/mkr_darwin_amd64.zip'
  sha256 '2e77e1ba7f0c754297a3d550b41ed0209d1a87aa5c3fb9c0ed6032cb6587f5c1'

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
