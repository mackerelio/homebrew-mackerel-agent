class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.43.0'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.43.0/mkr_darwin_amd64.zip'
  sha256 '90996626d4aa7b1c2211c9497873fbc2587dba7b5121f7f40b5ed64cd0f8e644'

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
