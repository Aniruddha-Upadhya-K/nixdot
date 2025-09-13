{ pkgs, ... }:

{
  imports = [];

  home.packages = with pkgs; [
    qalculate-gtk
  ];
}
