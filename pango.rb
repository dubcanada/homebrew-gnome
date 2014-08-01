require 'formula'

class Pango < Formula
  homepage "http://www.pango.org/"
  url "http://ftp.gnome.org/pub/GNOME/sources/pango/1.36/pango-1.36.5.tar.xz"
  sha256 "be0e94b2e5c7459f0b6db21efab6253556c8f443837200b8736d697071276ac8"

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'TingPing/gnome/cairo'
  depends_on 'harfbuzz'
  depends_on 'fontconfig'
  depends_on 'gobject-introspection'

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --enable-man
      --with-html-dir=#{share}/doc
      --enable-introspection=yes
      --without-xft
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/pango-querymodules", "--version"
  end
end
