class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.49.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.0/mkr_darwin_arm64.zip'
    sha256 'a4937b74d40217e16c4ea869077dca06c6f6d002bb46125fd19ce33b9aa4bc17'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.0/mkr_darwin_amd64.zip'
    sha256 '0b17850917bc71d04b9fe550d7be2cbf481dac3c49e380db86ce4ca537ab0e2d'
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
