class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.14.1'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.1/mkr_darwin_amd64.zip'
    sha256 'bb53a297e460fab74e9ba503dee047dbd932590674369526b2ed92630dbecd05'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.1/mkr_darwin_386.zip'
    sha256 '824a368922138ff23830d4096acadbe9dc3b903b250e815e4004282ae4750e7a'
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
