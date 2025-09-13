{ pkgs, lib, config, ... }:

{
  home.packages = [ pkgs.tmux-sessionizer ]; 

  home.file.".config/tms/config.toml".source = config.lib.file.mkOutOfStoreSymlink
    (lib.custom.relativeToRoot
      "home/ani/common/optional/development/tmux/config.toml");
}
