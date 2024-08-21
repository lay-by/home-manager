{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      # Base System
      wget
      git
      libsecret

      # Desktop
      wofi
      wayland-protocols
      wayland-utils
      wl-clipboard
      wlroots
      dunst

      # Development
      meson
      gcc
      glibc
      jq
      cachix
      bc
      ninja

      # Misc System
      breeze-icons
      gnome-tweaks
      ssh-askpass-fullscreen
      ;

    # Theme stuff
    inherit (pkgs.kdePackages) breeze;
    inherit (pkgs.libsForQt5) kdeconnect-kde plasma-systemmonitor;
    inherit (pkgs) seahorse breeze-gtk;
  };
}
