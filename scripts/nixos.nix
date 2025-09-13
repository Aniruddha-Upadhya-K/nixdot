{ pkgs, ... }:

{
  environment.systemPackages = [
    (import ./common/optional/screenshot.nix { inherit pkgs; })
    (import ./common/optional/hyprland.nix { inherit pkgs; })
  ];
}
