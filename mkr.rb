class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.3.0'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.3.0/mkr_darwin_amd64.zip'
    sha256 '2911e0d7cff0bcb2a1bce19fd243a2b3e060114d4e0561b227e9dcd5cfa5ac12'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.3.0/mkr_darwin_386.zip'
    sha256 'e28bf7d9fcc22cdfde0c7c8f31e3648a4847e7bda9cb69f309f24257eee3dd41'
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
