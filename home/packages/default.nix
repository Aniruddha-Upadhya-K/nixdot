{ config, pkgs, system, inputs, ... }: 

{ 
  imports = [
    # ./nvim
    ./terminal
    ./applications 
  ];
}
