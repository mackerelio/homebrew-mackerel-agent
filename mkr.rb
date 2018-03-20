class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.27.1'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.27.1/mkr_darwin_amd64.zip'
    sha256 '6faf0659526cf1a0dc015c40a18d237ac4de383ff03e2a379ddecaf16e7e396e'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.27.1/mkr_darwin_386.zip'
    sha256 '78013908c76733cff570acb6c515514fe459be2138f0f04626fd9db532ed3731'
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
