{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.libsForQt5.breeze-icons;
      name = "breeze-dark";
    };
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = lib.mkForce "gtk";
  #   style = {
  #     name = lib.mkDefault "breeze";
  #     package = pkgs.libsForQt5.breeze-qt5;
  #   };
  # };

  dconf.settings = {
    "org.cinnamon.desktop.interface" = {
      gtk-theme = "breeze-dark";
    };
  };
}
