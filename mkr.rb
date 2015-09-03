class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.4.1'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.4.1/mkr_darwin_amd64.zip'
    sha256 '34d5f6f9d01e7f1813b6c584d81ec8e703de3d6c7837062e0f068be74ac85e37'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.4.1/mkr_darwin_386.zip'
    sha256 '7a48a9d1ac57e93bc4caa5e86594509ffaec64201a759b8b15d332c2896e53f1'
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
