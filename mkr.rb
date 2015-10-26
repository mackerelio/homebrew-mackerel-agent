class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.7.0'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.7.0/mkr_darwin_amd64.zip'
    sha256 '38eb25ba68aedad8b808624adf8f63495e1aa2aa7d16acaba4230fa1fe770908'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.7.0/mkr_darwin_386.zip'
    sha256 '2dace1c0474d915e6b383b4d1beaf8eb4d53eba4f380161da21ee2145913ebf8'
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
