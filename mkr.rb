class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.29.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.29.0/mkr_darwin_amd64.zip'
    sha256 '64da40e69b8d2872caafd16cd0e6ff0877b4968e3ba6784f03c1b670307e097a'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.29.0/mkr_darwin_386.zip'
    sha256 'f5f48299a9a2f1d5818797184775dec6c10002579c88f0fa8d062e58b9e48794'
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
