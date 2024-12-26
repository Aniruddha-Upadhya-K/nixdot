{ config, pkgs, inputs, system, ... }:

{
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}"
  ];
}
