class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.6.0'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.6.0/mkr_darwin_amd64.zip'
    sha256 '6fc7ca180b437cc05a8da3483e345bbf9a4fb6850f944c0659c9fecbf02484e3'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.6.0/mkr_darwin_386.zip'
    sha256 'd1a1209369fc363cfb9e4d30d772613978f2f28c27a4f47326f8d8e19f9eab21'
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
