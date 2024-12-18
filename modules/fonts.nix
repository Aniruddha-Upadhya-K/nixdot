fonts = {
  enableDefaultPackages = true;
  packages = with pkgs; [
    liberation_ttf
    ubuntu_font_family
    (nerdfonts.override { fonts = [ "HackNerdFontMono" ]; })
  ];

  fontconfig = {
    defaultFonts = {
      serif = [  "Liberation Serif" ];
      sansSerif = [ "Ubuntu" ];
      monospace = [ "HackNerdFontMono" ];
    };
  };
};
