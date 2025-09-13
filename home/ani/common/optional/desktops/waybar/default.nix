{ config, lib, ... }:

{
  programs.waybar = {
    enable = true;
    style = lib.mkAfter ''
      @import url("./config.css");
    '';
  };

  home.file.".config/waybar/config.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink
    (lib.custom.relativeToRoot "home/ani/common/optional/desktops/waybar/config.jsonc");

  home.file.".config/waybar/config.css".source =
    config.lib.file.mkOutOfStoreSymlink
    (lib.custom.relativeToRoot "home/ani/common/optional/desktops/waybar/style.css");
}
