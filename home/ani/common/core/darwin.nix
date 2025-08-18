# Core home functionality that will only work on Darwin
{ config, lib, ... }:
{
  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.file.".config/karabiner/karabiner.json".source =
    config.lib.file.mkOutOfStoreSymlink
    (lib.custom.relativeToRoot "home/ani/common/core/extras/karabiner.json");
}
