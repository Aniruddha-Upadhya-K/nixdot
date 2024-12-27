{ config, pkgs, ... }:
  
{
  programs.neovim = {
    enable = true;

    package = pkgs.neovim-unwrapped;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    
    withPython3 = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      xclip
      ripgrep

      python3

      gcc

      # lua-language-server
      # luajitPackages.lua-lsp
    ];

    plugins = with pkgs.vimPlugins; [
      oil-nvim
      cloak-nvim
      luasnip
      lazygit-nvim
      nvim-web-devicons
      mason-nvim mason-lspconfig-nvim
      nvim-lspconfig
      none-ls-nvim
      undotree
      catppuccin-nvim
      codeium-vim
      nvim-ufo # fold
      harpoon2
      lualine-nvim
      render-markdown-nvim markdown-preview-nvim
      vim-tmux-navigator
      neo-tree-nvim
      auto-session
      telescope-nvim
      trouble-nvim
      alpha-nvim
      nvim-treesitter
    ];

    extraLuaConfig = ''
        -- Write lua code here
        -- or interpolate files like this
        ${builtins.readFile ./nvim/init.lua}
      '';
  };

  home.file.".config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}
