{
  inputs,
  lib,
  config,
  pkgs,
  stylix,
  ...
}:

{
  stylix = {
    enable = true;
    polarity = "dark";

    autoEnable = true;

    image = /home/hushh/Pictures/papes/romanbleedsolarized.png;

    cursor = {
      package = pkgs.libsForQt5.breeze-gtk;
      name = "Breeze-Dark";
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts;
        name = "Iosevka Nerd Font Mono";
      };

      emoji = {
        package = pkgs.twemoji-color-font;
        name = "Twitter Color Emoji";
      };

      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
  };
}
