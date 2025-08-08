{ pkgs, hostSpec, ... }:
let 
  fileManager = 
    if (hostSpec.defaults.fileManager == "nemo") then "${pkgs.nemo-with-extensions}"
    else "${pkgs.${hostSpec.defaults.fileManager}}";
in
{
  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${fileManager}/bin/${hostSpec.defaults.fileManager}";
      };
    };
  };
}
