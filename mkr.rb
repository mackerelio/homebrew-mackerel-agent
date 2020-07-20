class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.40.2'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.40.2/mkr_darwin_amd64.zip'
  sha256 'c25f916681765b4daf42a17b3579d5685130c4a126ed67d079f4d6d33efd5d93'

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
