class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.46.9'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.9/mkr_darwin_arm64.zip'
    sha256 '57231c70f405a1a796c77975bdb058c3985b5efb5bd62c72c273ba6cdaeb29a9'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.9/mkr_darwin_amd64.zip'
    sha256 '97730064d40a792c85119fde271c7df1a10142cdb32527b172719195103d7450'
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
