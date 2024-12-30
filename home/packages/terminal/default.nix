{ pkgs, system, inputs, ... }:

let
  nvim = inputs.nixvim.legacyPackages."${system}".makeNixvimWithModule {
    inherit pkgs;
    module = import ./nixvim;
  };
in {
  imports = [ ./tmux ./zsh ];

  home.packages = with pkgs; [ nvim ];
}
