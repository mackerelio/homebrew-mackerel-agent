class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.59.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.59.0/mkr_darwin_arm64.zip'
    sha256 'e997812e673722b35280bf515d7c7179c6899b55dc0092d7272f2de79d839a7d'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.59.0/mkr_darwin_amd64.zip'
    sha256 '3af178d85525f071c188f2ce20f7484bc8a34b106b3c818e156629d56f008b71'
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
