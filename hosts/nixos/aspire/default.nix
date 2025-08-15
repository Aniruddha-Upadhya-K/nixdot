#############################################################
#
#  aspire - Laptop
#  NixOS running on Ryzen 3, Radeon Vega 3, 8GB RAM
#
###############################################################

{
  inputs,
  lib,
  ...
}:
{
  imports = lib.flatten [
    #
    # ========== Hardware ==========
    #
    ./hardware-configuration.nix

    #
    # ========== Misc Inputs ==========
    #
    inputs.stylix.nixosModules.stylix

    (map lib.custom.relativeToRoot [
      #
      # ========== Required Configs ==========
      #
      "hosts/common/core"

      #
      # ========== Optional Configs ==========
      #
      "hosts/common/optional/services/greetd.nix" # display manager
      "hosts/common/optional/services/postgressql.nix" # postgres server
      "hosts/common/optional/services/printing.nix" # CUPS
      "hosts/common/optional/services/bluetooth.nix" # bluetooth tools and services
      "hosts/common/optional/audio.nix" # pipewire and cli controls
      "hosts/common/optional/docker.nix" 
      "hosts/common/optional/hyprland.nix" # window manager
      "hosts/common/optional/scanning.nix" # SANE and simple-scan
      "hosts/common/optional/nemo.nix" # file manager
      "hosts/common/optional/stylix.nix" # system theme
      "hosts/common/optional/thunar.nix" # file manager
      "hosts/common/optional/wayland.nix" # wayland components and pkgs not available in home-manager
      "hosts/common/optional/wifi.nix" # wayland components and pkgs not available in home-manager
    ])
  ];

  #
  # ========== Host Specification ==========
  #

  hostSpec = {
    hostName = "aspire";
    arch = "x86_64-linux"; # values should be one of "x86_64-linux", "aarch64-darwin" etc
    desktopEnv = "hyprland";

    defaults = {
      terminal = "kitty";
      fileManager = "nemo";
      launcher = {
        app = "rofi";
        cmd = "pkill rofi || rofi -show drun";
      };
      browser = "zen-beta";
    };
  };

  networking = {
    networkmanager.enable = true;
    # enableIPv6 = false;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      # When using plymouth, initrd can expand by a lot each time, so limit how many we keep around
      # configurationLimit = lib.mkDefault 10;
    };
    efi.canTouchEfiVariables = true;
    # timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
