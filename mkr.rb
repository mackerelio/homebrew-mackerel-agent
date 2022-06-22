class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.46.8'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.8/mkr_darwin_arm64.zip'
    sha256 '72e7f9887e6aaa5eb3f2a836c24d4d7c37495c73e663bc0c8330d7e1ddc7be83'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.8/mkr_darwin_amd64.zip'
    sha256 'bb0abf6d82dc566118d0a066e1482aa5aeece6bcc6447df82bf756ead2e045b0'
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
