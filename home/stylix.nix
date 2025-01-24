{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ../wallpapers/arcane.png;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "HackNerdFontMono";
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };
    };

    targets = {
      firefox.enable = false;
      hyprlock.enable = false;
    };
  };
}
