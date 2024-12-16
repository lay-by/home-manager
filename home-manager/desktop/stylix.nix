{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    polarity = "dark";
    autoEnable = true;

    targets.hyprlock.enable = false;
    #targets.hyprpaper.enable = false;

    image = /home/hushh/Pictures/papes/city.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";

    cursor = {
      package = pkgs.kdePackages.breeze;
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
