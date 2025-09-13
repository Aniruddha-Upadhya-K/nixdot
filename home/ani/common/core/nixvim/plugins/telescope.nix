{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<C-p>" = {
        action = "find_files";
        options = {
          desc = "Telescope find files";
        };
      };
      "<leader>fg" = {
        action = "live_grep";
        options = {
          desc = "Telescope live grep";
        };
      };
    };
    settings.defaults = {
      file_ignore_patterns = [
        "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "^.node-modules/"
      ];
      set_env.COLORTERM = "truecolor";
    };
    extensions = {
      ui-select = {
        enable = true;
        settings.specific_opts.codeactions = true;
      };
    };
  };
}
