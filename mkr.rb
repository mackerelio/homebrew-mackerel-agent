class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.46.1'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.1/mkr_darwin_arm64.zip'
    sha256 '938a25502864922af8410b28974a44a04a6659246efca6c4c86965b455ae6ee1'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.46.1/mkr_darwin_amd64.zip'
    sha256 '00cb6c1ceb7684871cf6de802d47ccf8446238205fe9397d0d5711928e674816'
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
