class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.10.0'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.10.0/mkr_darwin_amd64.zip'
    sha256 'ed584a5f0bddf12cd351e0b7af73ec5ae1ac742ec2fe83b11051fae35cd49e46'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.10.0/mkr_darwin_386.zip'
    sha256 '88e48a3b63b6fe738db55dd56221c137bbbba52b80074b07c8c33388ffae0b98'
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
