class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.57.1'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.57.1/mkr_darwin_arm64.zip'
    sha256 'e72495d5aa825b503a7ac8e06435248f7f913dc5d043de6cae233c6bed1150db'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.57.1/mkr_darwin_amd64.zip'
    sha256 '05f209d3fe2ee68b9d61255129922757e3aa5816b23d24eba6edc07f9441c4d6'
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
