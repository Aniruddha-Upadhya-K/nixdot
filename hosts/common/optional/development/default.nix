{ pkgs, ... }:

{
  # to include all the language specific environments
  imports = [
    ./cpp.nix
    ./javascript.nix
  ];

  # other languages
  environment.systemPackages = with pkgs; [
    python3
    jdk23
    cargo
    go
  ];
}
