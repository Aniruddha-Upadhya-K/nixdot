{ pkgs, ... }:
{
  plugins.lsp = {
    enable = true;

    servers = {
      bashls.enable = true;
      clangd.enable = true;
      cmake.enable = true;
      cssls.enable = true;
      gopls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      nixd.enable = true;
      prismals = {
        enable = true;
        package = null;
      };
      ruff.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      ts_ls.enable = true;
      tailwindcss.enable = true;
      yamlls.enable = true;
    };

    keymaps = {
      silent = true;
      diagnostic = {
        # Navigate in diagnostics
        "<leader>dk" = "goto_prev";
        "<leader>dj" = "goto_next";
      };

      lspBuf = {
        gd = "definition";
        gr = "references";
        gt = "type_definition";
        gi = "implementation";
        K = "hover";
        "<leader>r" = "rename";
        ca = "code_action";
      };

      extra = [
        {
          key = "<leader>gd";
          action = "<cmd>tab split | lua vim.lsp.buf.definition()<CR>";
        }
      ];
    };
  };
}
