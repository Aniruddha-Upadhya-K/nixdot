# Specifications For Differentiating Hosts
{ config, pkgs, lib, ... }: 
let 
  availableOpts = import ./availableOpts.nix;
in
{
  options.hostSpec = {
    # Data variables that don't dictate configuration settings
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of the host";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "The email of the user";
    };
    arch = lib.mkOption {
      type = lib.types.enum availableOpts.arch;
      description = "x86_64-linux | aarch64-darwin | ...";
    };
    handle = lib.mkOption {
      type = lib.types.str;
      description = "The handle of the user (eg: github user)";
    };
    home = lib.mkOption {
      type = lib.types.str;
      description = "The home directory of the user";
      default = 
        let 
          user = config.hostSpec.username;
        in 
          if pkgs.stdenv.isLinux then "/home/${user}" else "/Users/${user}";
    };

    # Configuration Settings
    isMinimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a minimal host";
    };
    # isServer = lib.mkOption {
    #   type = lib.types.bool;
    #   default = false;
    #   description = "Used to indicate a server host";
    # };

    # Sometimes we can't use pkgs.stdenv.isLinux due to infinite recursion
    isDarwin = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a host that is darwin";
    };
    isOled = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate whether the user has OLED screen";
    };
    isKeyboardBacklight = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description =
        "Used to indicate whether the system has keyboard backlights";
    };
    useWindowManager = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Used to indicate a host that uses a window manager";
    };
    desktopEnv = lib.mkOption {
      type = lib.types.enum availableOpts.desktopEnv;
      default = "hyprland";
      description = "Desktop enironment or window manager suite to be used";
    };
    # scaling = lib.mkOption {
    #   type = lib.types.str;
    #   default = "1";
    #   description = "Used to indicate what scaling to use. Floating point number";
    # };

    defaults = {
      terminal = lib.mkOption {
        type = lib.types.enum availableOpts.apps.terminals;
        default = "kitty";
        description = "Default terminal to be used";
      };
      fileManager = lib.mkOption {
        type = lib.types.enum availableOpts.apps.fileManagers;
        default = "nemo";
        description = "Default file manager to be used";
      };
      launcher = {
        app = lib.mkOption {
          type = lib.types.enum availableOpts.apps.launchers;
          default = "rofi";
          description = "Default application launcher to be used";
        };
        cmd = lib.mkOption {
          type = lib.types.str;
          default = "pkill rofi || rofi -show drun";
          description = "Default command to launch launcher set by window manager";
        };
      };
      browser = lib.mkOption {
        type = lib.types.enum availableOpts.apps.browsers;
        default = "zen-beta";
        description = "Default browser to be used";
      };
      editor = lib.mkOption {
        type = lib.types.enum availableOpts.apps.editors;
        default = "nvim";
        description = "Default editor to be used";
      };
    };
  };
}
