class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.8.0'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.8.0/mkr_darwin_amd64.zip'
    sha256 '686acf4b9f4c3ed49784260376e2718d18bd92554bc30f3662eb91ea723f8920'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.8.0/mkr_darwin_386.zip'
    sha256 '023030e905b371798cc47e2c68a0a6c72f3dd51b2433154f2fcf6ab324129730'
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
