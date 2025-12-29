{ config, pkgs, ... }:

{
  # Inspiration:
  # - https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265/20
  # - https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/programs/browsers/firefox.nix
  # - https://github.com/lucidph3nx/nixos-config/blob/2e42a40cc8d93c25e01dcbe0dacd8de01f4f0c16/modules/home-manager/firefox/default.nix
  # - https://github.com/Kreyren/nixos-config/blob/bd4765eb802a0371de7291980ce999ccff59d619/nixos/users/kreyren/home/modules/web-browsers/firefox/firefox.nix#L116-L148
  programs.firefox = {
    enable = true;
    # package =
      # (pkgs.wrapFirefox.override { libcanberra-gtk3 = pkgs.libcanberra-gtk2; })
      # pkgs.firefox-unwrapped { };

    # Refer to https://mozilla.github.io/policy-templates or `about:policies#documentation` in firefox
    policies = {
      AppAutoUpdate = false; # Disable automatic application update
      BackgroundAppUpdate =
        false; # Disable automatic application update in the background, when the application is not running.
      DefaultDownloadDirectory = "${config.home.homeDirectory}/downloads";
      DisableBuiltinPDFViewer = false;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = false; # Enable Firefox Sync
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false; # Managed by Proton
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        # Exceptions = ["https://example.com"]
      };
      ExtensionUpdate = true;
    };
  };
}
