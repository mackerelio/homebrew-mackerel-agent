class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.10.1'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.10.1/mkr_darwin_amd64.zip'
    sha256 '26f9ba46702b53a02e01e9b94bee80af5018763b646e0f825a49b9958c16cf45'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.10.1/mkr_darwin_386.zip'
    sha256 '47b82edd2500869579f76a3e3b909e3295f0fc75f438fadd945934e7ce7b4fbd'
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
