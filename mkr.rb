class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.53.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.53.0/mkr_darwin_arm64.zip'
    sha256 '6c3d15d257e90c2a0e0ac6028df54f0e2fb318d09d28aa4210ede1bbc95ba3b4'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.53.0/mkr_darwin_amd64.zip'
    sha256 '3219ec3be4847fdcf8cf0e4ea47e806db326549fee82686f5269a6fa1c0691bf'
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
