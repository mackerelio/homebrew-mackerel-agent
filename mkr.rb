class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.59.2'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.59.2/mkr_darwin_arm64.zip'
    sha256 '2a58389b6dd6c88af964a8598e0ee9eed0e1eda2f8e5a01603134bd6b801a3b9'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.59.2/mkr_darwin_amd64.zip'
    sha256 'bb5eb9efd56df9fc3f174c50952cb6b9e49fca1f4e499f502fc6434ffd124494'
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
