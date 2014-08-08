require 'formula'

class Gtkx3 < Formula
  homepage 'http://gtk.org/'
  
  url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/3.13/gtk+-3.13.5.tar.xz'
  sha256 '61d74eea74231b1ea4b53084a9d6fc9917ab0e1d71b69d92cbf60a4b4fb385d0'
  
  bottle do
      root_url 'http://dl.tingping.se/homebrew'
      sha1 "719600dc6e756fc86de376422d942f603827b08e" => :mavericks
  end

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
