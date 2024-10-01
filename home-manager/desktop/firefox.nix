{ pkgs, lib, inputs, ... }:
{
  imports = [
    {
      options = {
        programs.firefox.platforms.linux.vendorPath = mkOption {
          type = types.str;
          default = ".mozilla";
          description = "Path to the vendor directory for Firefox on Linux.";
        };
      };

      config = {
        programs.firefox.platforms.linux.vendorPath = ".zen";
      };
    }
  ];

  programs.firefox = {
    enable = true;
    package = inputs.zen-browser.packages.x86_64-linux.zen-browser;
    profiles.main = {
      isDefault = true;
      extensions = builtins.attrValues {
        inherit (pkgs.nur.repos.rycee.firefox-addons)
          ublock-origin # Ad Blocker
          sponsorblock # YouTube Sponsor Skipper
          return-youtube-dislikes
          violentmonkey # Browser Scripts
          darkreader # Dark Mode

          # Make tracking harder
          privacy-badger
          decentraleyes
          clearurls
          canvasblocker
          ublacklist
          ;
      };
    };
    #policies = lib.mkForce {
    #  DisableTelemetry = true;
    #  OfferToSaveLogins = true;
    #  OfferToSaveLoginsDefault = true;
    #  PasswordManagerEnabled = true;
    #  NoDefaultBookmarks = true;
    #  DisableFirefoxAccounts = true;
    #  DisableFeedbackCommands = true;
    #  DisableFirefoxStudies = true;
    #  DisableMasterPasswordCreation = false;
    #  DisablePocket = true;
    #  DisableSetDesktopBackground = true;
    #};
  };
}
