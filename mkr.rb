class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.49.3'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.3/mkr_darwin_arm64.zip'
    sha256 'b9e3fe51b68aadb45defccd01ab88ccb3536fecadf5b02003d4479965e688a66'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.49.3/mkr_darwin_amd64.zip'
    sha256 '47dec6894d773060a3cc69ceb1b198ae643dea6b82dcf236b1c7ce484be3f05f'
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
