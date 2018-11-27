class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.34.2'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.34.2/mkr_darwin_amd64.zip'
    sha256 '78969555e0ed0270a6386b3534be73474365ffeb920fdcd3ff1ca75c500965fa'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.34.2/mkr_darwin_386.zip'
    sha256 'c06e2de8efb52c3c13df6be65e7274af43d856abda544e2a6af9c5bd5631a32f'
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
