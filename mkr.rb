class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.14.4'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.4/mkr_darwin_amd64.zip'
    sha256 '17fc17a0b3aa17d30b0a1ddb49cd7c815e714c30500650edbc7118ded6b8e680'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.4/mkr_darwin_386.zip'
    sha256 'ab093834b268b29f6034da5b4bc8772d7940e090652ac8c3fe0043973195e70c'
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
