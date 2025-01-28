class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.59.1'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.59.1/mkr_darwin_arm64.zip'
    sha256 'a0e89bc34bd855806f0a4011323298ad2ce7e2e05118c98dc9e3a29f427c87f4'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.59.1/mkr_darwin_amd64.zip'
    sha256 '91538fa8a02dd43747daee2eef05680721233ed0d1da2575188d3345426ea406'
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
