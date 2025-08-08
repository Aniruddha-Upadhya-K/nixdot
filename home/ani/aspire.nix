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
    common/optional/browsers
    common/optional/desktops # default is hyprland
    common/optional/development
    common/optional/tools.nix
    common/optional
    common/optional/fileManager.nix
    common/optional/syncthing.nix
    common/optional/stylix.nix
    common/optional/xdg.nix # file associations
    common/optional/ui.nix
    # common/optional/atuin.nix
  ];
}
