{
  colorschemes.catppuccin = {
    enable = true;

    settings = {
      flavour = "mocha";
      show_end_of_buffer = false;

      dim_inactive = {
        enabled = true;
        shade = "light";
        percentage = 0.15;
      };

      default_integrations = true;
      integrations = {
        # alpha = true;
        harpoon = true;
        lualine = true;
        markdown = true;
        # gitsigns = true;
        cmp = true;
        treesitter = true;
        native_lsp = {
          enabled = true;
          virtual_text = {
            errors = ["italic"];
            hints = ["italic"];
            warnings = ["italic"];
            information = ["italic"];
            ok = ["italic"];
          };
          underlines = {
            errors = ["underline"];
            hints = ["underline"];
            warnings = ["underline"];
            information = ["underline"];
            ok =  ["underline"];
          };
          inlay_hints = {
            background = true;
          };
        };
        telescope = true;
        # trouble = true;
      };

      styles = {
        comments = ["italic"];
        conditionals = ["italic"];
      };

      color_overrides = {
        mocha = {
          base = "#171717";
          mantle = "#202020";
        };
      };
    };
  };
}
