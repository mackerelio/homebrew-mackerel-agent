class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.25.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.25.0/mkr_darwin_amd64.zip'
    sha256 'f1088e3c08bfaded80a22ef89745bd08e60cd8d4236b4ee8ef2933b0b706f4c3'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.25.0/mkr_darwin_386.zip'
    sha256 'a1dfe97a5cb6849627603de30ba400aec34e466ed8ee66da6ee21793ac5dd34b'
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
