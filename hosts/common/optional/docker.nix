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
  # will have to run
  # `colima start` before running docker commands
  # also dont forget to run 
  # `colima stop`
  environment.systemPackages = with pkgs; [ 
    docker 
    colima # container runtime
  ];
}
