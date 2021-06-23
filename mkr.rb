class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.45.2'
  url 'https://github.com/mackerelio/mkr/releases/download/v0.45.2/mkr_darwin_amd64.zip'
  sha256 'e0bb0c885064b9785a062c15eb24b21d1d4186506b6009fcc8fa8f8c023e171c'

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
