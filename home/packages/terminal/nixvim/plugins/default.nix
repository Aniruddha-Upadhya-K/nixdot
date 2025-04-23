{ pkgs, ... }: {
  imports = [
    ./completions.nix
    ./lsp.nix
    ./telescope.nix
    ./treesitter.nix
    ./oil.nix
    ./fold.nix
    ./git.nix
    ./catppuccin.nix
    ./nvim-jdtls.nix
    # ./dap.nix
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
        extensions = [ "oil" ];
        sections.lualine_x = [ "encoding" "filetype" ];
      };
    };

    markview = {
      enable = true;
      settings = {
        preview.hybrid_modes = [ "i" "c" ];
        preview.modes = [ "n" "x" "no" ];
      };
    };

    tmux-navigator.enable = true;

    nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
        fast_wrap.map = "<C-b>";
      };
    };

    indent-blankline.enable = true;
  };
}
