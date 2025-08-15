{ lib, hostSpec, ... }:

lib.warnIf (hostSpec.desktopEnv == null) "hostSpec.desktopEnv is not set"

{
  imports = lib.flatten [
    # Nixos setup
    (lib.optional (hostSpec.desktopEnv == "hyprland") [
      # Window Manager
      ./hyprland

      # Utils
      # Notification daemon
      ./services/dunst.nix

      # Application launcher
      ./rofi.nix

      # Wayland bar
      ./waybar
    ])

    # Nix-darwin setup
    (lib.optional (hostSpec.desktopEnv == "aerospace") [ ])
  ];
}
