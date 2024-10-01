{
  pkgs,
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
    ./hyprland/wofi.nix
    ./hyprland/dunst.nix
    ./desktop/stylix.nix
    #./desktop/firefox.nix
  ];

  nixpkgs = {
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

  home.packages = builtins.attrValues {
    inherit (pkgs)
      # Base apps    
      pavucontrol
      vesktop
      dolphin
      networkmanagerapplet
      ark
      desktop-file-utils
      unzip
      element-desktop
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
      libnvidia-container
      lutris
      wine
      winetricks
      r2modman

      # Development
      gnumake
      nixfmt-rfc-style
      meson
      cmake
      font-manager
      # nim
      nim
      nimble
      nimlsp
      nimlangserver
      nil
      devenv

      # Misc productivity
      grim
      swappy
      slurp
      neofetch
      nitch
      betterbird
      libreoffice
      p7zip
      _7zz
      file
      wlsunset
      killall

      # Media
      davinci-resolve
      blender
      playerctl
      yt-dlp
      kdenlive
      imagemagick
      gimp
      evince

      # Security
      nmap
      ;
    inherit (pkgs.kdePackages) kalgebra kcalc;
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userEmail = "44959695+lay-by@users.noreply.github.com";
      userName = "lay-by";
      delta.enable = true; # failing to compile for some reason (missing sqlite?)
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
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
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    fish.enable = true;
  };
  fonts.fontconfig.enable = true;
  services.easyeffects.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    TERM = "alacritty";
    DEFAULT_BROWSER = "${inputs.zen-browser.packages.x86_64-linux.zen-browser}/bin/zen";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
