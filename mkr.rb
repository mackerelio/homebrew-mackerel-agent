class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.52.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.52.0/mkr_darwin_arm64.zip'
    sha256 'fa549c2aa5b6e0904d8ce93b2e61d819f73996f1174df44cf9f874a948629f1a'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.52.0/mkr_darwin_amd64.zip'
    sha256 'abfb18fc460bd618c5c19bd292dcabcc9480fdbb949c7678e8c2c18a5e3bbfa6'
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
