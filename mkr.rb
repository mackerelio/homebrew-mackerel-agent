class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.49.1'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.1/mkr_darwin_arm64.zip'
    sha256 'b3e26fd2c3ccf91c527c8faa0e93bd313f6246a2641c4c914dd259537d659724'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.1/mkr_darwin_amd64.zip'
    sha256 '95af7475b79741c86edf01ed3a71de97a418dbfdef90804d09c16fc66be0e51d'
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
