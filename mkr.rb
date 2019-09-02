class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.39.1'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.39.1/mkr_darwin_amd64.zip'
    sha256 '58c7d76141f1f10d465cc8bd71dc0c83da48f1e8a8b222e479670f0fca8838e6'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.39.1/mkr_darwin_386.zip'
    sha256 '16cfe58305aabb565893578535b586de7defc4364d4b48b1cb55eaf5b7c664df'
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
