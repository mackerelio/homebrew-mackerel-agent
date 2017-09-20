class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.19.0'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.19.0/mkr_darwin_amd64.zip'
    sha256 'a8b5007a322de086d747eced5145a35697f46aa78e3fc45a98319fd6425410df'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.19.0/mkr_darwin_386.zip'
    sha256 'fe6a5ae882b09e074b84ab3d17544889ba9e102c59b7b24828adc85af9e805db'
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
