{ pkgs, lib, ... }:
let
  inputImage = lib.custom.relativeToRoot "wallpapers/rain-droplets.jpg";
  brightness = "-20";
  contrast = "0";
  fillColor = "black";
in {
  stylix = {
    enable = true;
    image = pkgs.runCommand "polished.png" { } ''
      ${pkgs.imagemagick}/bin/magick "${inputImage}" -brightness-contrast ${brightness},${contrast} -fill ${fillColor} $out
      '';
    polarity = "dark";
  };
}
