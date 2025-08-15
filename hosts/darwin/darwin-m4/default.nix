#############################################################
#
#  macbook air m4 - Laptop
#  Nix-darwin running on M4, 16GB RAM
#
###############################################################

{
  # inputs,
  config,
  lib,
  ...
}:
{
  imports = lib.flatten [
    #
    # ========== Misc Inputs ==========
    #
    # inputs.stylix.nixosModules.stylix

    (map lib.custom.relativeToRoot [
      #
      # ========== Required Configs ==========
      #
      "hosts/common/core"

      #
      # ========== Optional Configs ==========
      #
      "hosts/common/optional/homebrew.nix" # homebrew to install mac specific applications
      "hosts/common/optional/darwin-tools.nix"
      # "hosts/common/optional/services/postgressql.nix" # Currently nix-darwin does not support postgresql initialScript, ensureDatabases, or ensureUsers
      "hosts/common/optional/docker.nix" 
      # "hosts/common/optional/stylix.nix" # system theme
    ])
  ];

  #
  # ========== Host Specification ==========
  #

  hostSpec = {
    hostName = "darwin-m4";
    arch = "aarch64-darwin"; # values should be one of "x86_64-linux", "aarch64-darwin" etc
    isDarwin = true;
    desktopEnv = "aerospace";

    defaults = {
      terminal = "ghostty";
      launcher = {
        app = "choose-gui";
        cmd = ''
          pkill choose-gui || ls /Applications/ /Applications/Utilities/ /System/Applications/ /System/Applications/Utilities/ | \
          grep '\.app$' | \
          sed 's/\.app$//g' | \
          choose | \
          xargs -I {} open -na "{}.app"
        '';
      };
      browser = "zen-beta";
    };
  };

  nixpkgs.config.allowBroken = true;

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = 6;

  #
  # ========== Mac Defaults ==========
  #

  system = {
    primaryUser = config.hostSpec.username;
    defaults = {
      hitoolbox.AppleFnUsageType = "Do Nothing";

      ActivityMonitor = {
        ShowCategory = 101;
        SortDirection = 0;
      };

      trackpad.Clicking = true;

      NSGlobalDomain = {
        ### Important
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        AppleInterfaceStyle = "Dark";
        "com.apple.mouse.tapBehavior" = 1; # 1 enables tap to click

        # AppleScrollerPagingBehaviour = true;
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "WhenScrolling";
        AppleWindowTabbingMode = "manual";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.swipescrolldirection" = true; # true enables natural scrolling
        "com.apple.trackpad.enableSecondaryClick" = true; 
        "com.apple.trackpad.forceClick" = true;

        ### Unsure
        "com.apple.springing.enabled" = false; # spring loading (expose) for directories.
      };

      # windowManager = {
      #   EnableStandardClickToShowDesktop = false; # disable click wallpaper to reveal desktop
      #   EnableTilingByEdgeDrag = false;
      #   EnableTilingOptionAccelerator = false; # disable holding alt to tile windows
      #   EnableTopTilingByEdgeDrag = false; # disable dragging windows to the menu bar to fill the screen
      #   GloballyEnabled = false; # disable stage manager
      # };

      controlcenter = {
        AirDrop = false; 
        BatteryShowPercentage = true; # show a battery percentage in menu bar
      };

      dock = {
        autohide = true;
        launchanim = false;
        show-recents = false;
        tilesize = 64;

        # hot corner action for corners. 
        # 1 = disable
        # check https://nix-darwin.github.io/nix-darwin/manual/#opt-system.defaults.dock.wvous-bl-corner
        wvous-bl-corner = 1; 
        wvous-br-corner = 1; 
        wvous-tl-corner = 1; 
        wvous-tr-corner = 1; 

        # persistent-apps = [
        #   {
        #     app = "/Applications/${lib.toSentenceCase config.hostSpec.defaults.browser}.app";
        #   }
        #   {
        #     app = "/Applications/${lib.toSentenceCase config.hostSpec.default.terminal}.app";
        #   }
        # ];
      };
    };
  };
}
