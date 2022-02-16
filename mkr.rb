class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.46.3'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.3/mkr_darwin_arm64.zip'
    sha256 '24889d28565b6ea6cc1d173bc7069ee959477d3db89aa16712b9a5ebe15cb0cc'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.3/mkr_darwin_amd64.zip'
    sha256 'c23a58138e210ed0acf57390868ff633b28e2b52ab8fc31ee5ccab00b2bebc33'
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
