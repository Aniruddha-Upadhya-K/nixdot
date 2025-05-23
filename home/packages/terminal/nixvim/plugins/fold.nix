{ pkgs, ... }:

{
  extraPlugins = [pkgs.vimPlugins.promise-async];

  plugins.nvim-ufo = {
    luaConfig.pre = ''
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require("lspconfig")[ls].setup({
          capabilities = capabilities,
        })
      end
    '';
    enable = true;
  };
}
