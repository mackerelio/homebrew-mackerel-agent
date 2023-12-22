class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.54.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.54.0/mkr_darwin_arm64.zip'
    sha256 '6886af1db52fdab4da76db968694858ef14e60ec000b7eae80394ee58bca0677'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.54.0/mkr_darwin_amd64.zip'
    sha256 'f46168b68f61884cc1295b42be37b8516f09a06d11649a3b8bd16d44511c286e'
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
