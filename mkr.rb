class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.4.0'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.4.0/mkr_darwin_amd64.zip'
    sha256 '83c20e6b6811423426c5edaabf6676d74489cc817a7b85c897f6ecd102d82ab2'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.4.0/mkr_darwin_386.zip'
    sha256 '76596331bedfdd16ec1f34e213e6cd08a2ca01643356dc5db3258f8fe77d6693'
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
