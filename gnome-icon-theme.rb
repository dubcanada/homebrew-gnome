require "formula"

class GnomeIconTheme < Formula
  homepage "https://developer.gnome.org"
  url "http://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/3.12/gnome-icon-theme-3.12.0.tar.xz"
  sha1 "cc0f0dc55db3c4ca7f2f34564402f712807f1342"

  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "TingPing/gnome/gtk+3" => :build # for gtk3-update-icon-cache
  depends_on "icon-naming-utils" => :build
  depends_on "intltool" => :build

  def install
    ENV["GTK_UPDATE_ICON_CACHE"] = "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-icon-mapping"
    system "make", "install"
  end
  
  def post_install
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "-tf", "#{HOMEBREW_PREFIX}/share/icons"
  end
end
