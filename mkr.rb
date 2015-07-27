class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.3.1'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.3.1/mkr_darwin_amd64.zip'
    sha256 '5de62574771738a5d6ed7fdd25883b2e9dc97ab0ffec7c65c644c175f0ecbb42'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.3.1/mkr_darwin_386.zip'
    sha256 '91e2b9e9d7c39077a22be83e2f36bcd5d4e98a04da4d4cf16e729d6e751da5aa'
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
