{ hostSpec, pkgs, lib, ... }:

{
  home.packages = lib.flatten (with pkgs; [
    # Development
    tokei

    # Privacy
    keepassxc

    # Media
    ffmpeg

    (if hostSpec.isDarwin then vlc-bin else vlc)

    # Media production

    (lib.optional (!hostSpec.isDarwin) [
      # Office
      libreoffice

      # Media
      gthumb
      obs-studio
      gimp3-with-plugins
      blender
    ])
  ]);
} 
# // lib.optionalAttrs (hostSpec.isDarwin) {
#   homebrew = {
#     casks = [
#       "obs"
#       "gimp"
#       "blender"
#     ];
#   };
# }
