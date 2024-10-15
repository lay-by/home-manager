{ pkgs, inputs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = builtins.attrValues {
      inherit (pkgs)
        dina-font
        fira-code
        fira-code-symbols
        iosevka
        liberation_ttf
        meslo-lgs-nf
        monaspace
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        proggyfonts
        sarasa-gothic
        twemoji-color-font
        victor-mono
        vegur
        ;
      
      # These make builds a pain
      #sf-pro-nerd = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
      #sf-compact-nerd = inputs.apple-fonts.packages.${pkgs.system}.sf-compact-nerd;
      #sf-mono-nerd = inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd;
      #ny-nerd = inputs.apple-fonts.packages.${pkgs.system}.ny-nerd;
      nerdfonts = pkgs.nerdfonts.override {
        fonts = [
          "FiraCode"
          "Iosevka"
          "LiberationMono"
          "Meslo"
          "Monaspace"
          "Noto"
          "ProggyClean"
          "VictorMono"
        ];
      };
    };
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "Iosevka Nerd Font Mono"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Vegur"
          "Noto Color Emoji"
        ];
        serif = [
          "Vegur"
          "Noto Color Emoji"
        ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
