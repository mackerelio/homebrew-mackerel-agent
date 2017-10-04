class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.21.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.21.0/mkr_darwin_amd64.zip'
    sha256 '52c4571a7e1ee1611ae1e8540425f69a1db4b8688f1309089bffeece501e9d4b'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.21.0/mkr_darwin_386.zip'
    sha256 '5ccaab48ee7b498d0effbd44399cf283c5002627194228a6c6ecfd883c87dfaf'
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
