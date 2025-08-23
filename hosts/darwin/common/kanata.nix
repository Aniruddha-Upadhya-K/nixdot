{ config, pkgs, ... }:

{
  launchd.daemons = {
    "com.custom.kanata" = {
      command = "${pkgs.kanata}/bin/kanata -c ${config.hostSpec.home}/.config/kanata/kanata.kbd --port 5829 --debug";
      serviceConfig = {
        Label = "com.custom.kanata";
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/Library/Logs/Kanata/kanata.out.log";
        StandardErrorPath = "/Library/Logs/Kanata/kanata.error.log";
      };
    };

    "com.custom.karabiner-vhiddaemon" = {
      command = "/Library/'Application Support'/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";
      serviceConfig = {
        Label = "com.custom.karabiner-vhiddaemon";
        KeepAlive = true;
        RunAtLoad = true;
      };
    };

    "com.custom.karabiner-vhidmanager" = {
      command = "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate";
      serviceConfig = {
        Label = "com.custom.karabiner-vhidmanager";
        RunAtLoad = true;
      };
    };
  };
}
