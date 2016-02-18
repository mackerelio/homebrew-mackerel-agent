class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.9.0'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.9.0/mkr_darwin_amd64.zip'
    sha256 'd40dca37cf74e5b06573ca31ca4e792d747e0e4a5fe0910ccc7ea6421bb6a20b'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.9.0/mkr_darwin_386.zip'
    sha256 '6dd99ae12a064edc74b57c603585084d5a0417cedb5905e09928c20b8b30872c'
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
