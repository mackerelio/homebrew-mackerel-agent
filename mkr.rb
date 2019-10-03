class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.39.2'
  if Hardware::CPU.is_64_bit?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.39.2/mkr_darwin_amd64.zip'
    sha256 '00adabd7fd98f66e5649b3944a4ad7255e171abb5906f010d24a6e078858e52f'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.39.2/mkr_darwin_386.zip'
    sha256 '9c934a3f3123469f487c53fa728b86e8ccc27ae890e1d628d638a3489c926580'
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
