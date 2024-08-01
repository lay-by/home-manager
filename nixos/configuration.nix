{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
  ];

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "blind-faith";

  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hushh = {
    isNormalUser = true;
    description = "hushh";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "disk"
      "libvirtd"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Base System
    wget
    git
    libsecret
    #desktop
    hyprpaper
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    waybar
    wofi
    hyprpaper
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
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
    kdePackages.breeze
    ssh-askpass-fullscreen
    pkgs.libsForQt5.kdeconnect-kde
    seahorse
    # Theme stuff
    breeze-icons
    breeze-gtk
  ];

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    gamescope.enable = true;
    hyprland.enable = true;
    fish.enable = true;
    kdeconnect.enable = true;

    #use fish as main shell
    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    git = {
      enable = true;
      package = pkgs.gitFull;
      config.credential.helper = "libsecret";
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {

    steam = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          mono
          gtk3
          gtk3-x11
          libgdiplus
          zlib
        ];
    };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      meslo-lgs-nf
      victor-mono
      monaspace
      twemoji-color-font
      sarasa-gothic
      nerdfonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font Mono" ];
        sansSerif = [ "SF Pro Text" ];
        serif = [ "New York Medium" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };

  networking.firewall.enable = false;

  #set some annoying env vars to make sure gayland and nshitia play nice together
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    #LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    #GBM_BACKEND = "nvidia-drm";
    #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    WLR_DRM_NO_ATOMIC = "1";
    NIXOS_OZONE_WL = "1";
  };

  #configure extra nvidia options
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
  };

  #use newer nvidia package
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "555.58";
    sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
    sha256_aarch64 = lib.fakeSha256;
    openSha256 = lib.fakeSha256;
    settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
    persistencedSha256 = lib.fakeSha256;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  system.stateVersion = "24.05";
}
