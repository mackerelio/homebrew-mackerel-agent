class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.5.0'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.5.0/mkr_darwin_amd64.zip'
    sha256 '8a4a9e6df47cfc0aa58e082c716e025f772cd68516765feeefecaefd1d663239'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.5.0/mkr_darwin_386.zip'
    sha256 '596efc6a4e27aec4bae0f6137924b140856c42ef8d43fb86b83efbbd48e69a26'
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
