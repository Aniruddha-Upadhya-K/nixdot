# Core home functionality that will only work on Linux
{ config, pkgs, ... }:
let
  home = config.home;
in 
{
  services.ssh-agent.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${home.homeDirectory}/.desktop";
      documents = "${home.homeDirectory}/documents";
      download = "${home.homeDirectory}/downloads";
      music = "${home.homeDirectory}/media/audios";
      pictures = "${home.homeDirectory}/media/images";
      videos = "${home.homeDirectory}/media/videos";
      publicShare = "/var/empty"; #using this option with null or "/var/empty" barfs so it is set properly in extraConfig below
      templates = "/var/empty"; #using this option with null or "/var/empty" barfs so it is set properly in extraConfig below

      extraConfig = {
        # publicshare and templates defined as null here instead of as options because
        XDG_PUBLICSHARE_DIR = "/var/empty";
        XDG_TEMPLATES_DIR = "/var/empty";
      };
    };
  };

  home.packages = with pkgs; [
    xdg-utils # provide cli tools such as `xdg-mime` and `xdg-open`
    xdg-user-dirs
    wev # show wayland events. also handy for detecting keypress codes
  ];
}
