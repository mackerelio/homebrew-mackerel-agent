class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.38.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.38.0/mkr_darwin_amd64.zip'
    sha256 '00122b427d12ae61814d0186393546dc9e6378da344a1efa5c36af3c9cc48aea'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.38.0/mkr_darwin_386.zip'
    sha256 '261a5cca73a97b1f1471229cebd088bb7e1ea48a311108badb77935f46c69c45'
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
