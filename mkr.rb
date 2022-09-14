class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.47.1'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.47.1/mkr_darwin_arm64.zip'
    sha256 '8ff981b79b102a03c75ad2b08f8d7b8ef98fcf9feb78c911176766d0dbf4bfa2'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.47.1/mkr_darwin_amd64.zip'
    sha256 '1db447a8e09f3756bf52c3bac6c9c201183e880d012ab2a76da4918b7bc74b8a'
  end

  head do
    url 'https://github.com/mackerelio/mkr.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
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
