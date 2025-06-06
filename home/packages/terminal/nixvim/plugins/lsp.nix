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
      markdown_oxide.enable = true;
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
      astro.enable = true;
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
        "<leader>lr" = "references";
        "<leader>lt" = "type_definition";
        "<leader>li" = "implementation";
        "<leader>r" = "rename";
        "<leader>ca" = "code_action";
      };

      extra = [
        {
          key = "<leader>ld";
          action = "<cmd>vertical split | lua vim.lsp.buf.definition()<CR>";
        }
      ];
    };
  };
  plugins.none-ls = {
    enable = true;
    sources.formatting = {
      clang_format.enable = true;
      gofmt.enable = true;
      google_java_format.enable = true;
      isortd.enable = true;
      nixfmt.enable = true;
      prettierd = {
        enable = true;
        disableTsServerFormatter = false;
      };
      blackd.enable = true;
    };
    sources.diagnostics = {
      cppcheck.enable = true;
      pylint.enable = true;
    };
  };
  plugins.lint = {
    enable = true;
    lintersByFt = {
      c = [ "cppcheck" ];
      typescript = [ "eslint_d" ];
      python = [ "ruff" ];
      nix = [ "nix" ];
      go = [ "golangcilint" ];
      docker = [ "hadolint" ];
    };
  };
}
