class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.8.1'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.8.1/mkr_darwin_amd64.zip'
    sha256 '7536e10cd04c17c245e7a42fb3e679a0a733704ddf7401c0f0e8a18139f23d9c'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.8.1/mkr_darwin_386.zip'
    sha256 '5cc37aecc07d92b51d47ff755d5daa7b15531cb40f1e880ff1f6aab3931d88e4'
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
