{ pkgs, ... }:
{
  keymaps = [
    {
      key = "J";
      mode = "x";
      action = ":m '>+1<CR>gv=gv";
      options = {
        silent = true;
        noremap = true;
        desc = "Shift line down by 1 in visual mode";
      };
    }
    {
      key = "K";
      mode = "x";
      action = ":m '<-2<CR>gv=gv";
      options = {
        silent = true;
        noremap = true;
        desc = "Shift line up by 1 in visual mode";
      };
    }
    {
      key = "<C-d>";
      mode = "n";
      action = "<C-d>zz";
      options = {
        silent = true;
        noremap = true;
        desc = "Center cursor when scrolling down";
      };
    }
    {
      key = "<C-u>";
      mode = "n";
      action = "<C-u>zz";
      options = {
        silent = true;
        noremap = true;
        desc = "Center cursor when scrolling up";
      };
    }
    {
      key = "n";
      mode = "n";
      action = "nzzzv";
      options = {
        silent = true;
        noremap = true;
        desc = "Center cursor after searching next result";
      };
    }
    {
      key = "N";
      mode = "n";
      action = "Nzzzv";
      options = {
        silent = true;
        noremap = true;
        desc = "Center cursor after searching previous result";
      };
    }
    {
      key = "<leader>d";
      mode = ["n" "x"];
      action = "\"_d";
      options = {
        silent = true;
        noremap = true;
        desc = "Delete without yanking";
      };
    }
    {
      key = "<leader>dp";
      mode = "x";
      action = "\"_dp";
      options = {
        silent = true;
        noremap = true;
        desc = "[d]elete without yanking and [p]aste copied text";
      };
    }
    {
      key = "<leader>y";
      mode = ["n" "x"];
      action = "\"+y";
      options = {
        silent = true;
        noremap = true;
        desc = "Yank to the clipboard";
      };
    }
    {
      key = "<leader>p";
      mode = "n";
      action = "\"+p";
      options = {
        silent = true;
        noremap = true;
        desc = "Paste from the clipboard";
      };
    }
    {
      key = "<leader>kp";
      mode = "x";
      action = "<cmd>'<,'>copy '<-1<CR><S-v>";
      options = {
        silent = true;
        noremap = true;
        desc = "Clone selected lines above";
      };
    }
    {
      key = "<leader>jp";
      mode = "x";
      action = "<cmd>'<,'>copy '><CR><S-v>";
      options = {
        silent = true;
        noremap = true;
        desc = "Clone selected lines below";
      };
    }
    {
      key = "<leader>a";
      mode = ["n" "x"];
      action = "gg<S-v>G";
      options = {
        silent = true;
        noremap = true;
        desc = "Select [a]ll text";
      };
    }
    {
      key = "jk";
      mode = "i";
      action = "<Esc>";
      options = {
        silent = true;
        noremap = true;
        desc = "Enter to normal mode";
      };
    }
    {
      key = "<leader>s";
      mode = ["n" "x"];
      action = '':%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>'';
      options = {
        silent = true;
        noremap = true;
        desc = "[s]earch and replace all occurances of the word under cursor";
      };
    }
    {
      key = "<leader>(";
      mode = "x";
      action = ''c(<C-r>")<ESC>'';
      options = {
        silent = true;
        noremap = true;
        desc = "Add parenthesis [(] around selected text";
      };
    }
    {
      key = "<leader>[";
      mode = "x";
      action = ''c[<C-r>"]<ESC>'';
      options = {
        silent = true;
        noremap = true;
        desc = "Add square braces [[] around selected text";
      };
    }
    {
      key = "<leader><";
      mode = "x";
      action = ''c<<C-r>"><ESC>'';
      options = {
        silent = true;
        noremap = true;
        desc = "Add angular braces [<] around selected text";
      };
    }
    {
      key = ''<leader>"'';
      mode = "x";
      action = ''c"<C-r>""<ESC>'';
      options = {
        silent = true;
        noremap = true;
        desc = "Add double quotes [\"] around selected text";
      };
    }
    {
      key = "<leader>'";
      mode = "x";
      action = ''c'<C-r>"'<ESC>'';
      options = {
        silent = true;
        noremap = true;
        desc = "Add single quote ['] around selected text";
      };
    }

    # Plugin mapping

    # Oil
    {
      key = "<C-n>";
      mode = "n";
      action.__raw = ''
        function()
          local oil = require("oil")
          local util = require("oil.util")
          oil.open_float()
          util.run_after_load(0, function()
            oil.open_preview()
          end)
        end
      '';
      options = {
        silent = true;
        noremap = true;
        desc = "[p]roject [v]iew";
      };
    }
    # # Lsp restart
    # {
    #   key = "<leader>lspr";
    #   mode = "n";
    #   action = "<cmd>LspRestart<CR>";
    #   options = {
    #     noremap = true;
    #     desc = "[lsp] [r]estart";
    #   };
    # }
    # commentary
    {
      key = "<C-/>";
      mode = "n"; 
      action = "<cmd>Commentary<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Comment current line";
      };
    }
    {
      key = "<C-/>";
      mode = "x";
      action = "gc";
      options = {
        silent = true;
        remap = true;
        desc = "Comment current selection";
      };
    }
    # undotree
    {
      key = "<leader>u";
      mode = ["n" "x"];
      action = "<cmd>UndotreeToggle | UndotreeFocus<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Toggle undo tree";
      };
    }
  ];
}
