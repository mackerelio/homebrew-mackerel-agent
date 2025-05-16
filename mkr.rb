class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.61.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.61.0/mkr_darwin_arm64.zip'
    sha256 'd53bcdbd2ae3c92288ef67e98eb59cf970d71e306804b938533611f07688d016'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.61.0/mkr_darwin_amd64.zip'
    sha256 'e492b56f3e3cfda9e87d7fd9f58c26e66c238edcd3c50785b590b0deb037f103'
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
