{ pkgs, ... }:
let
  inputImage = ../wallpapers/spiderman.jpg;
  brightness = "-10";
  contrast = "0";
  fillColor = "black";
in {
  stylix = {
    enable = true;
    image = pkgs.runCommand "dimmed-background.png" { } ''
      ${pkgs.imagemagick}/bin/magick "${inputImage}" -brightness-contrast ${brightness},${contrast} -fill ${fillColor} $out
    '';

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
      tmux.enable = false;
    };
  };
}
