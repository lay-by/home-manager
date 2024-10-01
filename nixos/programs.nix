{ pkgs, ... }:
{
  programs = {
    thunar = {
      enable = true;
      plugins = builtins.attrValues { inherit (pkgs.xfce) thunar-archive-plugin thunar-volman; };
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    hyprland.enable = true;

    fish.enable = true;
    kdeconnect.enable = true;

    # Use fish as main shell
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
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/user/nix-config";
    };
  };
}
