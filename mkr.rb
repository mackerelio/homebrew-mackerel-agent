class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.22.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.22.0/mkr_darwin_amd64.zip'
    sha256 '2090e0f2669acc7260469b5e63ec047d1e7c26ecf3e8e5058f0963b8575c2887'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.22.0/mkr_darwin_386.zip'
    sha256 'b1e6a170883972f3a7aaf83bbb26a52cbe8d9cd324725eac2d0fec4be83c20b8'
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
