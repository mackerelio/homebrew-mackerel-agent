class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.24.1'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.24.1/mkr_darwin_amd64.zip'
    sha256 '1dbd9e6096a671c8c81fd6629a69f4784f03f48fe786780045872bb4bb2895ef'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.24.1/mkr_darwin_386.zip'
    sha256 '5ef2f3b1e44706c93f97f7e3a6a7a58491fbc40ebb8742358471abf4194bbb2a'
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
