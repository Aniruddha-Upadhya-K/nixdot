{ pkgs, ... }:

{
  home.packages = with pkgs; [
    liberation_ttf
    ubuntu-classic
    nerd-fonts.hack
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Ubuntu" ];
      monospace = [ "HackNerdFontMono" ];
    };
  };
}
