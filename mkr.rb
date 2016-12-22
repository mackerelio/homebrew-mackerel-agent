class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.14.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.0/mkr_darwin_amd64.zip'
    sha256 '9589b8a0b3013a4b5c80ea6f3b748d2e600cb2b4059f8e67b9a6b4931fb22b3d'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.0/mkr_darwin_386.zip'
    sha256 '73160e7b58603ab3dd185414c8235bc2998d18bf06fabed1548c783add8027cd'
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
