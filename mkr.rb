class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.46.7'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.7/mkr_darwin_arm64.zip'
    sha256 '0d290510f5718eeb0cdda812fb44c482741dcbca0ef50208b1c6fa043ccdf5a3'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.7/mkr_darwin_amd64.zip'
    sha256 '92c2eab1fe1c0ecf56c5a0597e8773a5357bbf606abd3ef8ebb01e2fb928ee90'
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
