{ pkgs, ... }:

{
  environment.systemPackages = [
    (import ./common/optional/hltags.nix {inherit pkgs;})
  ];
}
