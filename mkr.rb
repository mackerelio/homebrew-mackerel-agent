class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.64.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.64.0/mkr_darwin_arm64.zip'
    sha256 '214d57505496c8cefea93c71ae93b7abaea1f1431dfd725a81ce5c99bc59b8c1'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.64.0/mkr_darwin_amd64.zip'
    sha256 'cb7efab68f013a9a3209b9efa248fdada6e4bc98bf2a759150b6bddade9749b1'
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
