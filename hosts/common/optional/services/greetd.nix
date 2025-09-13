{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t --user-menu -r --remember-session -c Hyprland --power-shutdown 'poweroff' --power-reboot 'reboot' -d ~/tui.log";
        user = "greeter";
      };
    };
  };
}
