{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./fonts.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./nixpkgs.nix
    ./packages.nix
    ./programs.nix
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

        trusted-substituters = [
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://nix-gaming.cachix.org/"
        ];

        substituters = [
          "https://devenv.cachix.org"
          "https://nix-community.cachix.org"
          "https://cuda-maintainers.cachix.org"
          "https://nix-gaming.cachix.org/"
        ];
        
        trusted-public-keys = [
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        ];

        trusted-users = [
          "hushh"
        ];

      };
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Fix pipewire crackling
  security.rtkit.enable = true;

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
  };

  networking.firewall.enable = false;

  #set some annoying env vars to make sure gayland and nshitia play nice together
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    #GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    WLR_DRM_NO_ATOMIC = "1";
    NIXOS_OZONE_WL = "1";
    TERMINAL = "alacritty";
    EDITOR = "nvim";
    TERM = "alacritty";
    __GL_VRR_ALLOWED = "0";
  };

  # Ugly hack to fix a bug in egl-wayland, see
  #! https://github.com/NixOS/nixpkgs/issues/202454
  environment.etc."egl/egl_external_platform.d".source =
    let
      nvidia_wayland = pkgs.writeText "10_nvidia_wayland.json" ''
        {
            "file_format_version" : "1.0.0",
            "ICD" : {
                "library_path" : "${pkgs.egl-wayland}/lib/libnvidia-egl-wayland.so"
            }
        }
      '';
      nvidia_gbm = pkgs.writeText "15_nvidia_gbm.json" ''
        {
            "file_format_version" : "1.0.0",
            "ICD" : {
                "library_path" : "${config.hardware.nvidia.package}/lib/libnvidia-egl-gbm.so.1"
            }
        }
      '';
    in
    lib.mkForce (
      pkgs.runCommandLocal "nvidia-egl-hack" { } ''
        mkdir -p $out
        cp ${nvidia_wayland} $out/10_nvidia_wayland.json
        cp ${nvidia_gbm} $out/15_nvidia_gbm.json
      ''
    );

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  system.stateVersion = "24.05";
}
