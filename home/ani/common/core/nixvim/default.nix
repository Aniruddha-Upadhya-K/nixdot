{ pkgs, inputs, hostSpec, ... }:

let
  nvim = inputs.nixvim.legacyPackages."${hostSpec.arch}".makeNixvimWithModule {
    inherit pkgs;
    extraSpecialArgs = { inherit hostSpec; };
    module = import ./nixvim.nix;
  };
in {

  home.packages = with pkgs; [ nvim ];
}
