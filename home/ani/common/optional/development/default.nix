{ pkgs, ... }:

{
  imports = [
    ./tmux
  ];

  home.packages = with pkgs; [
    delta  # diffing
    nmap  # network mapper
  ];
}
