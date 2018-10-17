class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.32.1'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.32.1/mkr_darwin_amd64.zip'
    sha256 '9b9a7f187a56cfd874602a2fbf3182f013aa766f372f0dba66473ba399896f42'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.32.1/mkr_darwin_386.zip'
    sha256 'a8e78db5f08ae27e390829e3e5ffa279ae0ef93a46b2bfe9cd3b034d6d445dbe'
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
