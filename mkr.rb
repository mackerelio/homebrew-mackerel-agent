class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.14.2'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.2/mkr_darwin_amd64.zip'
    sha256 '17393f25e3dfe96411e5da8f72197b37af6b157a7edd291f684d98b2df01035d'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.14.2/mkr_darwin_386.zip'
    sha256 'b6bdebc49be66ce10894f109a44b3b7aafbf169e28869eccfd22893f94d77a95'
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
