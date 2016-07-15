class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.11.3'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.11.3/mkr_darwin_amd64.zip'
    sha256 'bd29ec6c00266319e28767cd4c442a5b8385f78774c68e8853cce7512687b24c'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.11.3/mkr_darwin_386.zip'
    sha256 '8dea8d6e9a9bbca439e4282fbdcd364fd120dea136f3114b6b82c69769827271'
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
