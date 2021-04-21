class Librevna < Formula
  desc "LibreVNA: 1MHz to 6GHz USB based vector network analyzer"
  homepage "https://groups.io/g/LibreVNA/"
  license "GPL-3.0"
  url "https://github.com/jankae/LibreVNA/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "7f7cf6efd76ce7a67f8402a0f967cfd965092088da836e45ecfc388c277371de"
  head "https://github.com/jankae/LibreVNA.git"

  depends_on "qt@5"
  depends_on "libusb"

  def install
    qt5 = Formula["qt@5"].opt_prefix
    
    cd "Software/PC_Application" do
      system "#{qt5}/bin/qmake", "LibreVNA-GUI.pro"
      system "make", "-j9"
      system "macdeployqt", "LibreVNA-GUI.app"
      prefix.install Dir["LibreVNA-GUI.app"]
      bin.install_symlink prefix/"LibreVNA-GUI.app/Contents/MacOS/LibreVNA-GUI"
    end
  end

  test do
    system "false"
  end
end
