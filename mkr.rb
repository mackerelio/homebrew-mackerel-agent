class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.47.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.47.0/mkr_darwin_arm64.zip'
    sha256 'b5f25d1bd3a5f334b69ad267a0a465f4d82d4483a311d52f53e221c4ef4c1a5c'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.47.0/mkr_darwin_amd64.zip'
    sha256 '2ba9e1f2b014dad680307487d2d422adfc12f18354dc5a97e27ad51d9c85dd92'
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
