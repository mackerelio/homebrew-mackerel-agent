class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.32.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.32.0/mkr_darwin_amd64.zip'
    sha256 'e65137901ffc257f9f156ff6f85cae8ffbe1665859abb5f49d26d131fe13ef46'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.32.0/mkr_darwin_386.zip'
    sha256 'a9740064282ef3aa2ca1171a0422ad6f4d47ac024d7c6f1530ff48d1356d7dbd'
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
