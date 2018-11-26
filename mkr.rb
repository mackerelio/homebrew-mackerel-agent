class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.34.1'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.34.1/mkr_darwin_amd64.zip'
    sha256 'e3d558b0307e04c8ace3690e153cde114128c15d777d11f35b09740dba5b81e3'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.34.1/mkr_darwin_386.zip'
    sha256 '29276f68fb23c05c6070e90627066debe646e738abab22c919a27f1dc5194ae5'
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
