{ pkgs, lib, ... }:
{
  nix.settings = {
    substituters = lib.mkBefore [ "https://hyprland.cachix.org" ];
    trusted-public-keys = lib.mkBefore [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true;
  };

  security.pam.services.hyprlock = { };

  environment.systemPackages = with pkgs; [
    hyprland-qtutils
    brightnessctl
    font-awesome
  ];
}
