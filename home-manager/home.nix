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

      # Gaming
      protontricks
      libnvidia-container
      lutris
      wine
      winetricks
      r2modman
      prismlauncher

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
      thunderbird
      libreoffice
      p7zip
      #_7zz
      file
      wlsunset
      killall
      okular
      piper
      wev
      
      #job123
      teams-for-linux

      # Media
      #davinci-resolve
      #blender
      playerctl
      yt-dlp
      #kdenlive
      imagemagick
      gimp
      evince
      alsa-utils

      # Security
      nmap
      ghidra
      ;
    inherit (pkgs.kdePackages) kalgebra kcalc;
    inherit (pkgs.jetbrains) webstorm rider;
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
    fish.enable = true;

    helix = {
      enable = true;
      languages.language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }];
    };

    #Fuckery to get around Titanfall 2's FPS cap. 
    mangohud = {
      enable = true;
      settings = {
        fps_limit = 200;
        no_display = true;
      };
    };
  };
  fonts.fontconfig.enable = true;
  services.easyeffects.enable = true;

  #services.hyprpaper = {
  #  enable = true;
  #  settings = {
  #    ipc = "on";
  #    preload = [
  #      "/home/hushh/Pictures/papes/mountain_uw.jpg"
  #      "/home/hushh/Pictures/papes/tokyo5.jpg"
  #    ];
  #    wallpaper = [
  #      "DP-1,/home/hushh/Pictures/papes/mountain_uw.jpg"
  #      "HDMI-A-1,/home/hushh/Pictures/papes/mountain_uw.jpg/tokyo5.jpg"
  #    ];
  #  };
  #};

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    TERM = "alacritty";
    DEFAULT_BROWSER = "${inputs.zen-browser.packages.x86_64-linux.default}/bin/zen";
  };

  xsession.numlock.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
