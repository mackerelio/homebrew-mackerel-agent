class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.51.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.51.0/mkr_darwin_arm64.zip'
    sha256 'fe9c6d9282014c811f7956939ba37c8f89be75056e50522bc71bedb42d5d8d17'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.51.0/mkr_darwin_amd64.zip'
    sha256 'a0e06281a872618eded064c2f074eecfc60d022379182a1c3603b5e4102dbe67'
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
