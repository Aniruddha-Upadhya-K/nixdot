{ pkgs, ... }:
{
  imports = [
    ./completions.nix
    ./lsp.nix
    ./telescope.nix
  ];
}
