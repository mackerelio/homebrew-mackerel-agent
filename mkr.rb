class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.35.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.35.0/mkr_darwin_amd64.zip'
    sha256 'e3930fcd06b971d161fda70f90a2d4dfb3612d2d7e8516c3a820021603285aac'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.35.0/mkr_darwin_386.zip'
    sha256 '4ea71e5f5aace88b86ac9b9b9a815f1433945d825411ae4b164fefe475b24682'
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
