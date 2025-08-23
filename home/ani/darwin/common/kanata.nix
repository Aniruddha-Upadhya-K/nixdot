{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kanata
  ];

  home.file.".config/kanata/kanata.kbd".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/kanata.kbd;
}
