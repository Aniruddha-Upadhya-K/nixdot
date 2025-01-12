{ pkgs, ... }:
{
  environment.systemPackages = [
    (import ./screenshot.nix { inherit pkgs; })
  ];
}
