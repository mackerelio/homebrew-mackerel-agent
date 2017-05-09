class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.16.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.16.0/mkr_darwin_amd64.zip'
    sha256 '412b3d4e5ca4ec99589c740f30ded97c61f660277790dc3b0b254fd008160b0f'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.16.0/mkr_darwin_386.zip'
    sha256 '64b7b48961964ecc2b55f954673310f2b172d6ab85869837168fcea243407417'
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
