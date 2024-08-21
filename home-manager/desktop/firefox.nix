{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.main = {
      isDefault = true;
      extensions = builtins.attrValues {
        inherit (pkgs.nur.repos.rycee.firefox-addons)
          ublock-origin # Ad Blocker
          sponsorblock # YouTube Sponsor Skipper
          dearrow # YouTube Clickbait Remover
          return-youtube-dislikes
          violentmonkey # Browser Scripts
          darkreader # Dark Mode

          # Make tracking harder
          privacy-badger
          decentraleyes
          clearurls
          canvasblocker
          ;
      };
    };
    policies = {
      DisableTelemetry = true;
      OfferToSaveLogins = true;
      OfferToSaveLoginsDefault = true;
      PasswordManagerEnabled = true;
      NoDefaultBookmarks = true;
      DisableFirefoxAccounts = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisableMasterPasswordCreation = false;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
    };
  };
}