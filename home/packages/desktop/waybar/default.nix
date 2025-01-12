{ pkgs, config, ... }:
let user = import ../../../user.nix;
in {
  programs.waybar = {
    enable = true;
    settings = {

    };
  };

  home.file.".config/waybar/config.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/${user}/.config/nixdot/home/packages/desktop/waybar/config.jsonc";

  home.file.".config/waybar/style.css".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/${user}/.config/nixdot/home/packages/desktop/waybar/style.css";
}
