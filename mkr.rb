class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.15.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.15.0/mkr_darwin_amd64.zip'
    sha256 'c9c72e63092087bbcf77664be8de5d1d090ac46a66ef66d0688dcd2753214166'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.15.0/mkr_darwin_386.zip'
    sha256 '3dff16c041441811df3b75ebc20b712ba6406cda15556f5189a5b334351f18d8'
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
