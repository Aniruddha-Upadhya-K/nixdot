{ pkgs, ... }:
{
  plugins = {
    cmp-nvim-lsp.enable = true;
    friendly-snippets.enable = true;
    cmp_luasnip.enable = true;
    luasnip = {
      enable = true;
      fromVscode = [ {} ];
    };
    lspkind = {
      enable = true;

      cmp = {
        enable = true;
        menu = {
          nvim_lsp = "[LSP]";
          nvim_lua = "[api]";
          path = "[path]";
          luasnip = "[snip]";
          buffer = "[buffer]";
        };
      };
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { 
            name = "buffer"; 
            # Words from other open buffers can also be suggested.
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
        ];
        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-z>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        window = {
          completion = {
            border = "rounded";
            side_padding = 1;
          };
          documentation = {
            border = "rounded";
            side_padding = 1;
          };
        };
      };
    };
  };
}
