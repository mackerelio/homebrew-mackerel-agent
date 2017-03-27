class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.14.5'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.5/mkr_darwin_amd64.zip'
    sha256 'c83414e3b2f45b321abd01ffbf3948e547954a9f94b76bcbcfe6ea3854bfd719'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.5/mkr_darwin_386.zip'
    sha256 'a1684251611e38ac250d3f23cc414b03c058d438b12142260048dba8818c0a18'
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
