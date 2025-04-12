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
  };
}
