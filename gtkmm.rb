require 'formula'

class Gtkmm < Formula
  homepage 'http://www.gtkmm.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/gtkmm/2.24/gtkmm-2.24.4.tar.xz'
  sha256 '443a2ff3fcb42a915609f1779000390c640a6d7fd19ad8816e6161053696f5ee'

  depends_on 'pkg-config' => :build
  depends_on 'glibmm'
  depends_on 'TingPing/gnome/gtk+'
  depends_on 'libsigc++'
  depends_on 'TingPing/gnome/pangomm'
  depends_on 'atkmm'
  depends_on 'TingPing/gnome/cairomm'

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
