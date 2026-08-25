class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.66.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.66.0/mkr_darwin_arm64.zip'
    sha256 '619fd325c1bda68b2a7bd0f1449411fbd5f7cbf894aa07bc292e944ff9e0019b'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.66.0/mkr_darwin_amd64.zip'
    sha256 '6664d419ac334ff366d6c525d56210b43db39a750d9fc61aa014ef97beafcadf'
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
