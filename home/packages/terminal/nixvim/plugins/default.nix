{ pkgs, ... }:
{
  imports = [
    ./completions.nix
    ./lsp.nix
    ./telescope.nix
    ./treesitter.nix
    ./oil.nix
    ./catppuccin.nix
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

    harpoon = {
      enable = true;
      enableTelescope = true;
      package = pkgs.vimPlugins.harpoon2;
    };
  };
}
