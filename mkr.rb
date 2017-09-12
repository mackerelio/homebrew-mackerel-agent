class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.18.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.18.0/mkr_darwin_amd64.zip'
    sha256 'd030902511470eba84410c894302fc9ac6eba492d65e5f6e883c4fc1c7bbffe9'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.18.0/mkr_darwin_386.zip'
    sha256 '615d3343351f0e72cc82371d67cb6bf1621389efa53f79f556b41514237cc12f'
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
