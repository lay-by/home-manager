{ config, lib, ... }:
with config.stylix.fonts; let
    colors = config.lib.stylix.colors.withHashtag;
in
{
  
  programs.wofi = {
    enable = true;
    settings = {
      height = 600;
      width = 400;
      allow_images = true;
      matching = "fuzzy";
    };
    style = lib.mkForce ''
      *{
        font-size: 14;
      }

      #scroll {
        border: 1px solid ${colors.base0B};
        border-radius: 5px;
        opacity: 0.8;
      }

      #input {
        border: 1px solid ${colors.base0B};
        border-radius: 5px;
        opacity: 0.8;
      }

      #text {
        opacity: 1; !important
      }
    '';
  };
}