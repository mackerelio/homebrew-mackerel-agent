class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.23.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.23.0/mkr_darwin_amd64.zip'
    sha256 'eabca41c88bc5acdd56ac8581fe963a9a85f344e22b266e901d2bbb8fd4611fe'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.23.0/mkr_darwin_386.zip'
    sha256 '063ffa5069d7d610831da9f6dc9b0f3f9d22a590cb572b6cae022e919228757a'
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
