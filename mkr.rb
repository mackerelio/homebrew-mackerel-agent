class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.39.3'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.39.3/mkr_darwin_amd64.zip'
  sha256 '6b7420881dd942a0334e6af62165a94424c9b83b5b941006e09ac82ef9fa50ee'

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
