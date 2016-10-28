class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.12.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.12.0/mkr_darwin_amd64.zip'
    sha256 '9b673cb04cd8a80c7ebb1f09e80a46501bef412dfa359a2ebbb8ed5a8be264d7'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.12.0/mkr_darwin_386.zip'
    sha256 '68af2b7ccc491a4bb11a8dce300e75fb565f67b5f486708a9137d0848e436768'
  end

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
