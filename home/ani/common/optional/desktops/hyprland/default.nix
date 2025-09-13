{ pkgs, inputs, config, hostSpec, lib, ... }:

{
  imports =  [
    ./hypridle.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    xwayland.enable = true;

    extraConfig = ''
      source = ./config.conf
    '';

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = hostSpec.defaults.terminal;
      "$fileManager" = hostSpec.defaults.fileManager;
      "$menu" = hostSpec.defaults.launcher.cmd;
      "$browser" = hostSpec.defaults.browser;

      #
      # ========== Environment Vars ==========
      #
      env = [
        "NIXOS_OZONE_WL, 1" # for ozone-based and electron apps to run on wayland
        "MOZ_ENABLE_WAYLAND, 1" # for firefox to run on wayland
        "MOZ_WEBRENDER, 1" # for firefox to run on wayland
        "XDG_SESSION_TYPE, wayland"
        "WLR_NO_HARDWARE_CURSORS, 1"
        "WLR_RENDERER_ALLOW_SOFTWARE, 1"
        "QT_QPA_PLATFORM, wayland"
      ];
    };
  };

  home.pointerCursor = {
    package = lib.mkForce pkgs.bibata-cursors;
    name = lib.mkForce "Bibata-Modern-Classic";
    hyprcursor = {
      enable = true;
    };
    gtk.enable = true;
    size = lib.mkForce 22;
  };

  programs.hyprlock = {
    enable = true;
    extraConfig = lib.mkAfter ''
      source = ./hyprlock-config.conf
    '';
  };

  home.file.".config/hypr/config.conf".source =
    config.lib.file.mkOutOfStoreSymlink
    (lib.custom.relativeToRoot "home/ani/common/optional/desktops/hyprland/hyprland.conf");

  home.file.".config/hypr/hyprlock-config.conf".source =
    config.lib.file.mkOutOfStoreSymlink
    (lib.custom.relativeToRoot "home/ani/common/optional/desktops/hyprland/hyprlock.conf");

  # Screenshot annotation
  home.file.".config/satty/config.toml".source = ./satty.toml;
}
