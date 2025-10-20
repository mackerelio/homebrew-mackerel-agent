class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.62.3'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.62.3/mkr_darwin_arm64.zip'
    sha256 'd1405271cd9c1de7bd011363150ee7d0b860a4b081a299dd7d56a49c4ac4957d'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.62.3/mkr_darwin_amd64.zip'
    sha256 '408a3e49b2ece1fd4301d9cde31e3ede824776f82d0d2472e3719267f88b9c70'
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
