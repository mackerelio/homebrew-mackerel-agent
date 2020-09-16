class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.40.3'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.40.3/mkr_darwin_amd64.zip'
  sha256 '82fc1d6987ea737943583de4bd88595ec6df35548da5e906ee636bbc48260d2b'

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
