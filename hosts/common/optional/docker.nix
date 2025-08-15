{ isDarwin, pkgs, ... }:

if !isDarwin then {
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
} else {
  environment.systemPackages = with pkgs; [ docker ];
}
