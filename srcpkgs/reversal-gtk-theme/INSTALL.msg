To force Libadwaita applications to use the gtk-4.0 theme,
symlink the gtk-4.0 theme to the config folder
(replace Reversal-Dark with your chosen theme variant):

mkdir -p ~/.config/gtk-4.0/
ln -sf /usr/share/themes/Reversal-Dark/gtk-4.0/{assets,gtk.css,gtk-dark.css} ~/.config/gtk-4.0/

To install the Firefox theme, copy or symlink from /usr/share/doc/reversal-gtk-theme/firefox/:
https://github.com/yeyushengfan258/Reversal-gtk-theme/tree/main/src/other/firefox#installation
