class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.46.5'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.5/mkr_darwin_arm64.zip'
    sha256 '2e8b0b77618ddec024905078755d4b97ba1d9ff6cc09123322663d6e62bc693b'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.5/mkr_darwin_amd64.zip'
    sha256 '2066e21f4110eae04622f738821690243754822445ec83057ab9ff68086359fb'
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
