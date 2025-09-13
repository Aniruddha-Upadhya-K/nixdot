{ pkgs, ... }:
{
  # general packages related to wayland
  environment.systemPackages = with pkgs; [
    grim # screen capture component, required by flameshot
    hyprshot
    satty
    
    wl-screenrec # screen record

    wl-clipboard # clipboard
  ];
}
