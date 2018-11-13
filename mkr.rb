class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.33.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.33.0/mkr_darwin_amd64.zip'
    sha256 '504270d2e426bec4d1b14d5fbcab281823305cd26511482f1f906428386f5e89'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.33.0/mkr_darwin_386.zip'
    sha256 'af8e11e2b547903e02e047229beabb39edca590c3691f4fde3abdd5321cb1468'
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
