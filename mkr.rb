class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.11.2'
  if Hardware.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.11.2/mkr_darwin_amd64.zip'
    sha256 'ae3554d4456408fde7dd0e384260e879bf9dc0e8d26f469dee47262abf8e830a'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.11.2/mkr_darwin_386.zip'
    sha256 '48a2370d64ffab06a69706281d9e2c003b7d9343d736f7786bd83487de44e2ba'
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
