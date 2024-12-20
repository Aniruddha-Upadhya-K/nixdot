{ pkgs, ... }:
{
  imports = [
    ./completions.nix
    ./lsp.nix
    ./telescope.nix
    ./treesitter.nix
    ./oil.nix
  ];

  plugins = {
    web-devicons.enable = true;

    commentary.enable = true;

    undotree = {
      enable = true;
      settings = {
        autoOpenDiff = true;
        focusOnToggle = true;
      };
    };
  };
}
