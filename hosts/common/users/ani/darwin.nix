# User config applicable only to darwin
{ config, pkgs, ... }:
{
  users.users.${config.hostSpec.username} = {
    home = "/Users/${config.hostSpec.username}";
  };

  environment.systemPackages = with pkgs; [ 
    git 
  ];

  # root's ssh key are mainly used for remote deployment, borg, and some other specific ops
  users.users.root = {
    shell = pkgs.zsh;
  };
}
