class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.44.2'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.44.2/mkr_darwin_amd64.zip'
  sha256 '39e49a33769e4e8601b8ed5be0d9703b6c1e1e107737bada662bd878d6bd257a'

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
