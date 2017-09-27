class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.20.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.20.0/mkr_darwin_amd64.zip'
    sha256 '95a4aa5553a0ed58173a801325a780200a9071653d314a7a9c7fd51977c44764'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.20.0/mkr_darwin_386.zip'
    sha256 '77f320e6468c4502d3ab13e86f2bff9ebcc2685253329a167760ec8300d6cd51'
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
