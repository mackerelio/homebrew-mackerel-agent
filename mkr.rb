class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.40.4'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.40.4/mkr_darwin_amd64.zip'
  sha256 '7fdaa1be2ea21ec535a00cab98b0dcbee0037ad12a36fd7f3d6f3e3757419ed0'

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
