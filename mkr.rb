class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.39.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.39.0/mkr_darwin_amd64.zip'
    sha256 '385ca3996bbd8df2ce6a35685b330beae81105854189881d9f081ad1c3b4451a'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.39.0/mkr_darwin_386.zip'
    sha256 'a29e0e69795f491afcd73adf93c5b29033a28862a0aa0f65b6820e14dcbd6eb9'
  end

  head do
    url 'https://github.com/mackerelio/mkr.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/mackerelio'
      ln_s buildpath, buildpath/'.go/src/github.com/mackerelio/mkr'
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
