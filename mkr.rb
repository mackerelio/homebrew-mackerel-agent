class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.7.1'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.7.1/mkr_darwin_amd64.zip'
    sha256 '306cc7ae1709f52f5959dd858c833ffa63a2c20e0f87c34484810d6272d43741'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.7.1/mkr_darwin_386.zip'
    sha256 '92a5aeeb0400ecfa65f58f8ed6e63f167d166566e032420f6af28eb59cbd121f'
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
