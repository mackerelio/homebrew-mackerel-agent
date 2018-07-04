class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.31.1'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.31.1/mkr_darwin_amd64.zip'
    sha256 '0a47ed77ea47c7cea6085740e23d26cb92ed010cb9cd560c6cbbc7c1078fb1d7'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.31.1/mkr_darwin_386.zip'
    sha256 'cb37a7e69f4c2ea35e48499978d93f7011e76a7f0626318132be19590405fec9'
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
