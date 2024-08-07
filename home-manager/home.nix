{ pkgs, spicetify-nix, ... }:
{
  imports = [
    ./hyprland/waybar.nix
    ./hyprland/hypridle.nix
    ./hyprland/hyprland.nix
    ./hyprland/hyprlock.nix
    ./desktop/stylix.nix
    ./hyprland/dunst.nix
  ];

  nixpkgs = {
    overlays = [ ];
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
      breeze-icons
      konsole
      ark
      desktop-file-utils
      rofi-wayland
      unzip
      element-desktop
      gimp
      hyprshot
      hyprcursor
      htop
      mpv

      # Gaming
      gpu-screen-recorder
      gpu-screen-recorder-gtk
      protontricks
      gwe
      libnvidia-container
      lutris

      # Development
      neovim
      vscode
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

      # Theme stuff
      papirus-folders
      ;

    inherit (pkgs.kdePackages) breeze;
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
            #fullAppDisplay # Shows the song cover, title, and artist in fullscreen.
            fullAlbumDate
            popupLyrics # Popup window with the current song's lyrics scrolling across it
            shuffle # Shuffle properly, using Fisher-Yates with zero bias
            ;
        };
      };
  };
  fonts.fontconfig.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
