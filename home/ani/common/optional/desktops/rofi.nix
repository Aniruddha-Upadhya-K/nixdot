{ pkgs, hostSpec, ... }:

{
  programs.rofi = {
    enable = hostSpec.defaults.launcher.app == "rofi";
    package = pkgs.rofi-wayland;
    extraConfig = {
      show-icons = true;
    };
  };
}
