class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.56.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.56.0/mkr_darwin_arm64.zip'
    sha256 '1ef8871d93e537717c92ebf6e1dc549cf56737996de92c3042757c4dc3fe24eb'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.56.0/mkr_darwin_amd64.zip'
    sha256 'c73e99fb7d950fe86cad677641f8d377dced61d0e61f4047e613a0a046bc0b7d'
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
