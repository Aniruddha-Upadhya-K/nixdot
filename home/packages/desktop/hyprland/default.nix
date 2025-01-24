{ pkgs, inputs, config, lib, ... }:
let user = import ../../../user.nix;
in {
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
  services.hypridle.enable = true;

  home.file.".config/hypr/config.conf".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/${user}/.config/nixdot/home/packages/desktop/hyprland/hyprland.conf";

  home.file.".config/hypr/hyprlock-config.conf".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/${user}/.config/nixdot/home/packages/desktop/hyprland/hyprlock.conf";

  home.file.".config/hypr/hypridle.conf".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/${user}/.config/nixdot/home/packages/desktop/hyprland/hypridle.conf";

  # Screenshot annotation
  home.file.".config/satty/config.toml".source = ./satty.toml;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
}
