{ pkgs, inputs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      # Base System
      wget
      git
      libsecret
      ffmpeg

      # Desktop
      wayland-protocols
      wayland-utils
      wl-clipboard
      wlroots

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

      # QEMU
      qemu
      quickemu

      #security
      wireshark
      ;

    #zen-browser = pkgs.zen-browser.packages.x86_64-linux.zen-browser;
    # Theme stuff
    inherit (pkgs.kdePackages) breeze;
    inherit (pkgs.libsForQt5) kdeconnect-kde plasma-systemmonitor;
    inherit (pkgs) seahorse breeze-gtk;
    inherit (inputs.zen-browser.packages.x86_64-linux) zen-browser;
  };
}
