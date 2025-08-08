{ pkgs, config, lib, hostSpec, ... }:

{
  programs.waybar = {
    enable = true;
    style = lib.mkAfter ''
      @import url("./config.css");
    '';
  };

  home.file.".config/waybar/config.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/${hostSpec.username}/.config/nixdot/home/packages/desktop/waybar/config.jsonc";

  home.file.".config/waybar/config.css".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/${hostSpec.username}/.config/nixdot/home/packages/desktop/waybar/style.css";
}
