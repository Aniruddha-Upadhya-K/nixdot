{
  arch = [ "x86_64-linux" "aarch64-darwin" ];

  desktopEnv = [
    "hyprland"

    # not supported yet
    "aerospace" # mac os only
    "sway"
    "gnome"
    "kde"
    "wayfire"
  ];

  apps = {
    browsers = [
      "brave"
      "firefox"
      "zen-beta"
      "zen-twilight"

      # not supported yet
      "chromium"
      "floorp"
      "librewolf"
      "vivaldi"
    ];
    terminals = [
      "kitty"

      # not supported yet
      "ghostty"
      "alacritty"
      "wezterm"
    ];
    fileManagers = [
      "nemo"
      "thunar"

      # not supported yet
      "marta" # mac os only
      "nautilus"
      "dolphin"
    ];
    launchers = [
      "rofi"

      # not supported yet
      "choose-gui" # for mac os
      "wofi"
    ];
    editors = [
      "nvim"

      # not supported
      "emacs"
    ];
  };
}
