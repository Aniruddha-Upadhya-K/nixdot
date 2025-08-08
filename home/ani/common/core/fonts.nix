{ pkgs, ... }:

{
  home.packages = with pkgs; [
    liberation_ttf
    ubuntu_font_family
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
