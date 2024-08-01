{
  inputs,
  lib,
  config,
  pkgs,
  stylix,
  ...
}:
{
  imports = [
    ./hyprland/waybar.nix
    ./hyprland/hyprland.nix
    ./desktop/stylix.nix
    # ./hyprland/dunst.nix
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      cudaSupport = true;
    };
  };

  home = {
    username = "hushh";
    homeDirectory = "/home/hushh";
  };

  home.packages = with pkgs; [
    #base apps    
    firefox
    pavucontrol
    vesktop
    dolphin
    networkmanagerapplet
    breeze-icons
    konsole
    spotify
    ark
    kdePackages.breeze
    desktop-file-utils
    rofi-wayland
    unzip
    element-desktop
    gimp
    hyprshot
    hyprcursor
    htop
    mpv
    #gaming
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    protontricks
    gwe
    libnvidia-container
    lutris
    #development
    neovim
    vscode
    gnumake
    nixfmt-rfc-style
    meson
    cmake
    font-manager
    #misc productivity
    gimp
    grim
    swappy
    slurp
    kdenlive
    playerctl
    # Theme stuff
    papirus-folders
  ];

  xdg.desktopEntries = {
    spotify = {
      type = "Application";
      name = "Spotify (Adblock)";
      genericName = "Music Player";
      icon = "spotify-client";
      categories = [
        "Audio"
        "Music"
        "Player"
        "AudioVideo"
      ];
      exec = "env LD_PRELOAD=/home/hushh/nix-config/home-manager/spotify-adblock.so spotify";
    };
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userEmail = "44959695+lay-by@users.noreply.github.com";
      userName = "lay-by";
      delta.enable = true;
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
  fonts.fontconfig.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
