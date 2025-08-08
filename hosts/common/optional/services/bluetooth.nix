{ ... }:
{
  hardware = {
    bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket"; # Allow A2DP profile
          Experimental = true; # Show battery of the bluetooth devices
        };
      };
    };
  };

  services.blueman.enable = true;
}
