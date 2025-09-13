{ inputs, config, hostSpec, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    policies = let
      locked = value: {
        Value = value;
        Status = "locked";
      };
    in {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true; 
      DisablePocket = true; # save webs for later reading DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        # Exceptions = ["https://example.com"]
      };

      # doesnt work in darwin for some reason
      ExtensionSettings = (
        let 
          extension = uuid: shortUrl: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${shortUrl}/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        in builtins.listToAttrs [
          # ublock Origin
          (extension "uBlock0@raymondhill.net" "ublock-origin")

          # vimium-ff
          (extension "{d7742d87-e61d-4b78-b8a1-b469842139fa}" "vimium-ff")

          # keepassxc
          (extension "keepassxc-browser@keepassxc.org" "keepassxc-browser")
        ]
      );
      Preferences = builtins.mapAttrs (_: locked) {
        "browser.tabs.warnOnClose" = true;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
      };

      # Unsure if these will work or not
      DefaultDownloadDirectory = "${config.home.homeDirectory}/downloads";
      DisableBuiltinPDFViewer = false;
      DisableFirefoxAccounts = false; # Enable Firefox Sync
      ExtensionUpdate = true;
    };

    profiles.main = {
      id = 0;
      name = "Default";
      isDefault = true;

      settings = {
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.activity-stream.showWeather" = false;
        "layout.css.devPixelsPerPx" = if !hostSpec.isDarwin then 0.875 else -1.0;  # Important, otherwise everything is too much zoomed in linux
        "zen.urlbar.replace-newtab" = false;
        "zen.workspaces.continue-where-left-off" = true;
        "zen.workspaces.show-workspace-indicator" = true;
      };
    };
  };
}
