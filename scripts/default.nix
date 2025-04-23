{ pkgs, ... }:
{
  environment.systemPackages = [
    (import ./screenshot.nix { inherit pkgs; })
    (import ./hyprland.nix { inherit pkgs; })
  ];
}
