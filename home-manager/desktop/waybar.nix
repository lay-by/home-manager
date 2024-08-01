{
  inputs,
  lib,
  config,
  pkgs,
  stylix,
  ...
}:
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-center = [ "custom/music" ];
        modules-left = [
          "custom/startmenu"
          "hyprland/workspaces"
          "custom/weather"
        ];
        modules-right = [
          "custom/nvidia"
          "cpu"
          "memory"
          "clock"
        ];

        height = 14;

        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format = '' {:L%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "hyprland/window" = {
          max-length = 22;
          separate-outputs = false;
        };
        "memory" = {
          interval = 1;
          format = " {}%";
          tooltip = true;
        };
        "cpu" = {
          interval = 1;
          format = " {usage:2}%";
          tooltip = true;
        };
        "disk" = {
          format = " {free}";
          tooltip = true;
        };
        "tray" = {
          spacing = 12;
        };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          # exec = "rofi -show drun";
          on-click = "sleep 0.1 && rofi-launcher";
        };
        "custom/hyprbindings" = {
          tooltip = false;
          format = "󱕴";
          on-click = "sleep 0.1 && list-hypr-bindings";
        };
        "custom/music" = {
          format = "󰎇 {} 󰎇";
          interval = 1;
          on-click = "playerctl -p spotify play-pause";
          exec = "/home/hushh/nix-config/home-manager/desktop/scripts/music.sh";
        };
        "custom/nvidia" = {
          format = " {}";
          interval = 1;
          exec = "/home/hushh/nix-config/home-manager/desktop/scripts/nvidia.sh";
        };
        # There might already be a custom module for this but I'm just going to use my old script.
        "custom/weather" = {
          interval = 900;
          exec = "/home/hushh/nix-config/home-manager/desktop/scripts/weather.sh";
        };
      }
    ];

    style = lib.concatStrings [
      ''
        * {
          font-family: Iosevka Nerd Font Mono;
          font-size: 14px;
          border-radius: 0px;
          border: none;
          min-height: 0;
        }
      ''
    ];
  };
}