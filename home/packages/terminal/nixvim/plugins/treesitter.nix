{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      dockerfile
      go
      html
      java
      javascript
      json
      lua
      make
      markdown
      markdown-inline
      nix
      python
      regex
      rust
      sql
      toml
      vim
      vimdoc
      xml
      yaml
    ];

    settings.highlight.enable = true;
    settings.indent.enable = true;
  };
}
