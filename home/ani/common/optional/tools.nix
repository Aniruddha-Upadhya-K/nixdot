{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development
    tokei

    # Office
    libreoffice

    # Privacy
    keepassxc

    # Media
    ffmpeg
    vlc
    gthumb

    # Media production
    blender
    gimp3-with-plugins
    obs-studio
  ];
}
