{
  pkgs,
  spicetify-nix,
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hyprland/waybar.nix
    ./hyprland/hypridle.nix
    ./hyprland/hyprland.nix
    ./hyprland/hyprlock.nix
    ./hyprland/dunst.nix
    ./desktop/stylix.nix
    ./desktop/firefox.nix
    ./hyprland/wofi.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      #cudaSupport = true;
    };
  };

  home = {
    username = "hushh";
    homeDirectory = "/home/hushh";
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)
      # Base apps    
      firefox
      pavucontrol
      vesktop
      dolphin
      networkmanagerapplet
      ark
      desktop-file-utils
      unzip
      #element-desktop
      gimp
      hyprshot
      hyprcursor
      htop
      mpv
      alacritty
      gwenview

      # Gaming
      gpu-screen-recorder
      gpu-screen-recorder-gtk
      protontricks
      gwe
      libnvidia-container
      lutris
      wine
      winetricks

      # Development
      gnumake
      nixfmt-rfc-style
      meson
      cmake
      font-manager

      # Misc productivity
      grim
      swappy
      slurp
      kdenlive
      playerctl
      yt-dlp
      neofetch
      ;
    inherit (pkgs.kdePackages) kalgebra;
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userEmail = "44959695+lay-by@users.noreply.github.com";
      userName = "lay-by";
      #delta.enable = true; #failing to compile for some reason (missing sqlite?)
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    spicetify =
      let
        spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        enabledExtensions = builtins.attrValues {
          inherit (spicePkgs.extensions)
            adblock # NO❗❗❗ 🙀 😾 HOW WILL SPOTIFY MAKE MONEY FROM THEIR AI-GENERATED SONGS AND KEEP ALL THE PROFITS FOR THEMSELVES?! *(Allegedly)*
            beautifulLyrics # Apple Music like Lyrics
            copyLyrics
            fullAlbumDate
            popupLyrics # Popup window with the current song's lyrics scrolling across it
            shuffle # Shuffle properly, using Fisher-Yates with zero bias
            ;
        };
      };

    vscode.enable = true;
    neovim.enable = true;
    alacritty = {
      enable = true;
      settings = {
        font.size = lib.mkForce 10;
      };
    };
  };
  fonts.fontconfig.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
