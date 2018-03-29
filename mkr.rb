class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.28.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.28.0/mkr_darwin_amd64.zip'
    sha256 'f3011d0acb99cd51d5ac311071fb43a87a89448c289e38a9a938ecfb5f5695f0'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.28.0/mkr_darwin_386.zip'
    sha256 'f16396a2f852a9dd6faa99250b22c93e4949b8ee4ffb5eb16840dda3d3d63dcf'
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
