{ config, pkgs, system, inputs, ... }: 

let
  nvim = inputs.nixvim.legacyPackages."${system}".makeNixvimWithModule {
    inherit pkgs;
    module = import ./terminal/nixvim;
  };
in 
{ 
  imports = [
    # ./nvim
    ./terminal
    ./applications 
  ];

  home.packages = with pkgs; [
    nvim
  ];
}
