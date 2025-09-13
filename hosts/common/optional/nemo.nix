{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    nemo-with-extensions
  ];

  services.udisks2.enable = true;
}
