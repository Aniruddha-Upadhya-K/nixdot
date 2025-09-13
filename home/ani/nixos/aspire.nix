{ ... }:

{
  imports = [
    #
    # ========== Required Configs ==========
    #
    ../common/core

    #
    # ========== Host-specific Optional Configs ==========
    #
    ../common/optional
    ../common/optional/browsers
    ../common/optional/desktops # default is hyprland
    ../common/optional/development
    ../common/optional/fileManager.nix
    ../common/optional/stylix.nix
    ../common/optional/syncthing.nix
    ../common/optional/tools.nix
    ../common/optional/ui.nix
    ../common/optional/xdg.nix # file associations
    # common/optional/atuin.nix
  ];
}
