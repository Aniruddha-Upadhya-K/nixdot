# Specifications For Differentiating Hosts
{ config, pkgs, lib, ... }: 
let 
  inherit (lib) types;
  availableOpts = import ./availableOpts.nix;
in
{
  options.hostSpec = {
    # Data variables that don't dictate configuration settings
    username = lib.mkOption {
      type = types.str;
      description = "The username of the host";
    };
    hostName = lib.mkOption {
      type = types.str;
      description = "The hostname of the host";
    };
    email = lib.mkOption {
      type = types.str;
      description = "The email of the user";
    };
    arch = lib.mkOption {
      type = types.enum availableOpts.arch;
      description = "x86_64-linux | aarch64-darwin for now";
    };
    handle = lib.mkOption {
      type = types.str;
      description = "The handle of the user (eg: github user)";
    };
    home = lib.mkOption {
      type = types.str;
      description = "The home directory of the user";
      default = 
        let 
          user = config.hostSpec.username;
        in 
          if pkgs.stdenv.isLinux then "/home/${user}" else "/Users/${user}";
    };

    # Configuration Settings
    isMinimal = lib.mkOption {
      type = types.bool;
      default = false;
      description = "Used to indicate a minimal host";
    };
    # isServer = lib.mkOption {
    #   type = types.bool;
    #   default = false;
    #   description = "Used to indicate a server host";
    # };

    # Sometimes we can't use pkgs.stdenv.isLinux due to infinite recursion
    isDarwin = lib.mkOption {
      type = types.bool;
      default = false;
      description = "Used to indicate a host that is darwin";
    };
    isOled = lib.mkOption {
      type = types.bool;
      default = false;
      description = "Used to indicate whether the user has OLED screen";
    };
    isKeyboardBacklight = lib.mkOption {
      type = types.bool;
      default = false;
      description =
        "Used to indicate whether the system has keyboard backlights";
    };
    desktopEnv = lib.mkOption {
      type = types.nullOr (types.enum availableOpts.desktopEnv);
      default = null;
      description = "Desktop enironment or window manager suite to be used";
    };
    # scaling = lib.mkOption {
    #   type = types.str;
    #   default = "1";
    #   description = "Used to indicate what scaling to use. Floating point number";
    # };

    defaults = {
      terminal = lib.mkOption {
        type = types.nullOr (types.enum availableOpts.apps.terminals);
        default = null;
        description = "Default terminal to be used";
      };
      fileManager = lib.mkOption {
        type = types.nullOr (types.enum availableOpts.apps.fileManagers);
        default = null;
        description = "Default file manager to be used";
      };
      launcher = {
        app = lib.mkOption {
          type = types.nullOr (types.enum availableOpts.apps.launchers);
          default = null;
          description = "Default application launcher to be used";
        };
        cmd = lib.mkOption {
          type = types.nullOr (types.str);
          default = null;
          description = "Default command to launch launcher set by window manager";
        };
      };
      browser = lib.mkOption {
        type = types.nullOr (types.enum availableOpts.apps.browsers);
        default = null;
        description = "Default browser to be used";
      };
      editor = lib.mkOption {
        type = types.enum availableOpts.apps.editors;
        default = "nvim";
        description = "Default editor to be used";
      };
    };
  };
}
