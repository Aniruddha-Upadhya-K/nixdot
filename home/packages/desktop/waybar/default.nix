{ pkgs, config, lib, ... }:
let user = import ../../../user.nix;
in {
  programs.waybar = {
    enable = true;
    style = lib.mkAfter ''
      @import url("./config.css");
    '';
  };

  home.file.".config/waybar/config.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/${user}/.config/nixdot/home/packages/desktop/waybar/config.jsonc";

  home.file.".config/waybar/config.css".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/${user}/.config/nixdot/home/packages/desktop/waybar/style.css";
}
