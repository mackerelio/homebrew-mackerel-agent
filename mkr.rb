class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.62.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.62.0/mkr_darwin_arm64.zip'
    sha256 'c888989d43e1eb86cf1d69ca767191a41026c804d9a7a75475e11151b23b3561'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.62.0/mkr_darwin_amd64.zip'
    sha256 'f673951e51b83d0f27c991e03764cfdc6920b8272e47bbf1a5c0054b327c215d'
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
