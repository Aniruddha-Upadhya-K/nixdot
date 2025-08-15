{ ... }:

{
  imports = [
    #
    # ========== Required Configs ==========
    #
    common/core

    #
    # ========== Host-specific Optional Configs ==========
    #
    common/optional
    common/optional/browsers
    common/optional/desktops # default is hyprland for linux & aerospace for mac
    common/optional/development
    common/optional/syncthing.nix
    common/optional/tools.nix
    # common/optional/stylix.nix
    # common/optional/ui.nix
    # common/optional/atuin.nix
  ];
}
