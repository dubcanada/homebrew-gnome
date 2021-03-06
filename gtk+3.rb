require 'formula'

class Gtkx3 < Formula
  homepage 'http://gtk.org/'
  
  url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/3.13/gtk+-3.13.5.tar.xz'
  sha256 'c8648197d0a79edda0faeab6c17d18f32118dfb1922e747738964a04336e9631'

  depends_on 'pkg-config' => :build
  depends_on 'jasper' => :optional
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'glib'
  depends_on 'gobject-introspection'
  depends_on 'gdk-pixbuf'
  depends_on 'atk'
  depends_on 'TingPing/gnome/pango'
  depends_on 'TingPing/gnome/cairo'

  def install
    # gtk-update-icon-cache is used during installation, and
    # we don't want to add a dependency on gtk+2 just for this.
    inreplace %w[ gtk/makefile.msc.in
                  demos/gtk-demo/Makefile.in
                  demos/widget-factory/Makefile.in ],
                  /gtk-update-icon-cache --(force|ignore-theme-index)/,
                  "#{buildpath}/gtk/\\0"

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--enable-introspection=yes",
                          "--enable-quartz-backend",
                          "--disable-schemas-compile"
    system "make install"
    # Prevent a conflict between this and Gtk+2
    mv bin/'gtk-update-icon-cache', bin/'gtk3-update-icon-cache'
  end
end
