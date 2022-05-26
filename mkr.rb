class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.46.6'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.6/mkr_darwin_arm64.zip'
    sha256 '40c090cc91b925acb302550e5eed557a8b3d48223caac62fc18559e15224910d'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.6/mkr_darwin_amd64.zip'
    sha256 '1f087b9c16a726bb3333c51a732fa602b2800f099e399398587e8a99b9933117'
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
