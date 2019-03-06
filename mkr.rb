class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.35.1'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.35.1/mkr_darwin_amd64.zip'
    sha256 'dddbd0ec9b6205069f1098aa34e442f5e279fc77fe21156a47acabcdb40d5f31'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.35.1/mkr_darwin_386.zip'
    sha256 '06b6fd8aba745a774e6c836d22b2b105184dcf618d35dac2144430182605107a'
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
