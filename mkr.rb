class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.46.4'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.4/mkr_darwin_arm64.zip'
    sha256 '77af3c69599859819485f32042f0f956091cbb59e5e8fe8f0fa928d6f1157c9b'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.4/mkr_darwin_amd64.zip'
    sha256 'b4b510a3d546c3d640ad5cb115709fde00294193b2d4ed4c8359980b7b184efe'
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
