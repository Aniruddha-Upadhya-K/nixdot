# Reminder that CUPS cpanel defaults to localhost:631

{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
    #logging = "debug";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Mitigate cups and avahi security issue as described here: https://discourse.nixos.org/t/cups-cups-filters-and-libppd-security-issues/52780/2
  # Note: this will eventually be achievable with the option `services.printing.browsed.enabled = false` but the PR hasn't been merged to unstable as of 09.10.24
  # systemd.services.cups-browsed = {
  #   enable = false;
  #   unitConfig.Mask = true;
  # };
}
