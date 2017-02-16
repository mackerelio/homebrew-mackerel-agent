class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.14.3'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.3/mkr_darwin_amd64.zip'
    sha256 'c0dca79f43b95bb45d5e19bfa2b2095721e42d6f940060543003e53de25e59b1'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.3/mkr_darwin_386.zip'
    sha256 '859a3cb976297fb46c2477c44f26ed771cb8d8066f5b5dc22a78281a1fb288f8'
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
