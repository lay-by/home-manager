{ pkgs, inputs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      dina-font
      fira-code
      fira-code-symbols
      iosevka
      liberation_ttf
      meslo-lgs-nf
      monaspace
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      proggyfonts
      sarasa-gothic
      twemoji-color-font
      victor-mono
      vegur
      
      pkgs.nerd-fonts.iosevka
      pkgs.nerd-fonts.noto
    ];
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
