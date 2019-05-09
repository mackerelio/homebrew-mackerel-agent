class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.37.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.37.0/mkr_darwin_amd64.zip'
    sha256 'fbea55609ebc42126686c463ef89d24f33907b339c448ca27b3583c5c147e298'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.37.0/mkr_darwin_386.zip'
    sha256 '905466fb982d8e6a53115291a6c0556f38f9b4a8226c56369ab033905aa90225'
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
