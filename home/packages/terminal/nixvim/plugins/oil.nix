{ pkgs, ... }:
{
  plugins.oil = {
    enable = true;
    settings.keymaps = {
      "<C-l>" = false;
      "<C-h>" = false;
      "<C-r>" = "actions.refresh";
      "-" = "actions.parent"; 
      "<C-p>" = "actions.preview";
      "<C-.>" = "actions.toggle_hidden";
      "<C-k>" = "actions.show_help";
      "<C-n>" = "actions.close";
      "<Esc>" = "actions.close";
    };
    settings.float.win_options.winblend = 10;
  };
}
