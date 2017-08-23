class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.17.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.17.0/mkr_darwin_amd64.zip'
    sha256 '390496371732b86a0415b9452469394c8db3e0e9e941834b389638d348b9943c'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.17.0/mkr_darwin_386.zip'
    sha256 '963c0cf277a4ef7365c7b505059c04697a2f2372d2a82b46db0d1552a4800294'
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
