class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.27.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.27.0/mkr_darwin_amd64.zip'
    sha256 '1449a3201d134f14efc5f0333e3aa67fb9e7046f9aec5c102ae9950d0f3b79d3'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.27.0/mkr_darwin_386.zip'
    sha256 '3e294d5d4474c4e191647093479dac73f635137ed0760f47e73906003bd5228e'
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
