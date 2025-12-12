To force Libadwaita applications to use the gtk-4.0 theme,
symlink the gtk-4.0 theme to the config folder
(replace Colloid-Dark with your chosen theme variant):

mkdir -p ~/.config/gtk-4.0/
ln -sf /usr/share/themes/Colloid-Dark/gtk-4.0/{assets,gtk.css,gtk-dark.css} ~/.config/gtk-4.0/

To install the Firefox theme, copy or symlink from /usr/share/doc/colloid-gtk-theme/firefox/:
https://github.com/vinceliuice/Colloid-gtk-theme/tree/main/src/other/firefox#installation
