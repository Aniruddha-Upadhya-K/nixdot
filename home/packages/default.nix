{ config, pkgs, system, inputs, ... }: 

{ 
  imports = [
    # ./nvim
    ./desktop
    ./terminal
    ./applications 
  ];
}
