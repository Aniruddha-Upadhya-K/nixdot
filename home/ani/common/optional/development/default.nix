{ pkgs, ... }:

{
  imports = [
    ./tmux
    ./starship.nix
  ];

  home.packages = with pkgs; [
    delta  # diffing
    nmap  # network mapper
  ];
}
