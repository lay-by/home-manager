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
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    #inputs.hyprland.homeManagerModules.default
    ./hyprland/waybar.nix
    ./hyprland/hyprland.nix
    ./desktop/stylix.nix
    # ./hyprland/dunst.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "hushh";
    homeDirectory = "/home/hushh";
  };

  # Add stuff for your user as you see fit:
  #programs.neovim.enable = true;
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

  # Enable home-manager and git
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
