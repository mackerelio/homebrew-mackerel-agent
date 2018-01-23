class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.26.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.26.0/mkr_darwin_amd64.zip'
    sha256 '1d0f686ae16e8361f69dd3e47e9f08486b5719991868e2a6bb637aa6c674452f'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.26.0/mkr_darwin_386.zip'
    sha256 '1fa87eb4a3620d0715256f3ab1dbd0efd531217adb0817c13b490badb51caf58'
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
