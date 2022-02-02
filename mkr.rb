class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.46.2'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.2/mkr_darwin_arm64.zip'
    sha256 'bce541fc627aeb88b8f0f07ee7a1793f18a48172e31e017571f44853863bd81f'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.2/mkr_darwin_amd64.zip'
    sha256 'd0ca0cefb07b6f90425bfda78b5e0a0a8c16be1bfdcc77f903c8afa08a03868d'
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
