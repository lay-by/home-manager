{ config, lib, pkgs, ... }:
with config.stylix.fonts; let
    colors = config.lib.stylix.colors.withHashtag;
in
{
  
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    #extraConfig = {
    #  location = "center";
    #  width = 300; 
    #  height = 600;
    #  background-color = "${colors.base0B}";
    #};
  };
}
