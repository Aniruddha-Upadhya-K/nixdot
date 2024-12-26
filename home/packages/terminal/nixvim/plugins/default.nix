{ pkgs, ... }:
{
  imports = [
    ./completions.nix
    ./lsp.nix
    ./telescope.nix
    ./treesitter.nix
    ./oil.nix
    ./catppuccin.nix
    ./fold.nix
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

    lualine = {
      enable = true;
      settings = {
        options.theme = "moonfly";
        extensions = ["oil"];
        sections.lualine_x = ["encoding" "filetype"];
      };
    };

    markview = {
      enable = true;
      settings = {
        hybrid_modes = ["i" "c"];
        modes = ["n" "x" "no"];
      };
    };
  };
}
