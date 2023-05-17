class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  version '0.50.0'
  if Hardware::CPU.arm?
    url 'https://github.com/mackerelio/mkr/releases/download/v0.50.0/mkr_darwin_arm64.zip'
    sha256 '82562a980474b6f95f0c42637cda610ea87b67e85e816f1bed21e02e6750a05e'
  else
    url 'https://github.com/mackerelio/mkr/releases/download/v0.50.0/mkr_darwin_amd64.zip'
    sha256 '15d5827c20d6b3118924e90586141206b7248f578331820bd176cefad4078333'
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
