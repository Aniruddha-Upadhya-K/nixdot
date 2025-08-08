{ pkgs, hostSpec, ... }:

{
  imports = [ 
    ./plugins 
    ./keymaps.nix 
  ];

  globals = { mapleader = " "; };

  viAlias = true;
  vimAlias = true;
  withNodeJs = true;
  withPython3 = true;

  extraPackages = with pkgs; [ typescript ripgrep ];

  clipboard.providers.wl-copy = {
    enable = !hostSpec.isDarwin;
    package = pkgs.wl-clipboard;
  };

  diagnostic.settings = {
    virtual_lines = { current_lines = true; };
    virtual_text = true;
  };

  opts = {
    number = true;
    relativenumber = true;
    mouse = "a"; # Enable mouse control
    mousemodel = "extend"; # Mouse right-click extends the current selection
    splitbelow = true; # A new window is put below the current one
    splitright = true; # A new window is put right of the current one
    ignorecase =
      true; # When the search query is lower-case, match both lower and upper-case
    smartcase =
      true; # Override the 'ignorecase' option if the search pattern contains upper case characters
    termguicolors = true; # Enables 24-bit RGB color in the |TUI|
    wrap = true;
    swapfile = false;
    backup = false;
    undofile = true;
    incsearch = true;
    scrolloff = 8;

    # Tab options
    shiftwidth = 2;
    tabstop = 2;
    expandtab = true;
    smartindent = true;

    # Folding
    foldenable = true;
    foldmethod = "expr";
    foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()";
    foldtext = "";
    foldlevel = 99; # Folds with a level higher than this number will be closed
    foldlevelstart = 99;
    foldcolumn = "1";
  };
}
