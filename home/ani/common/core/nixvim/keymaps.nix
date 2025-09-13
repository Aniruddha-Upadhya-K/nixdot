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
      key = "jk";
      mode = ["i" "c"];
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
      key = "<leader>{";
      mode = "x";
      action = ''c{<C-r>"}<ESC>'';
      options = {
        silent = true;
        noremap = true;
        desc = "Add square braces [{] around selected text";
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
    # Harpoon telescope ui
    {
      key = "<C-e>";
      mode = "n";
      action.__raw = ''
        function()
          local harpoon = require("harpoon")
          local function toggle_telescope(harpoon_files)
            local conf = require("telescope.config").values

            local file_paths = {}

            for _, item in ipairs(harpoon_files.items) do
              table.insert(file_paths, item.value)
            end

            local make_finder = function()
              local paths = {}
              for _, item in ipairs(harpoon_files.items) do
                table.insert(paths, item.value)
              end

              return require("telescope.finders").new_table({
                results = paths,
              })
            end

            require("telescope.pickers").new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
              attach_mappings = function(prompt_buffer_number, map)
                map("i", "<C-d>", function()
                  local state = require("telescope.actions.state")
                  local selected_entry = state.get_selected_entry()
                  local current_picker = state.get_current_picker(prompt_buffer_number)

                  harpoon:list():remove(selected_entry)
                  current_picker:refresh(make_finder())
                end)

                return true
              end,
            }):find()
          end
          toggle_telescope(harpoon:list())
        end
      '';
      options = {
        silent = true;
        noremap = true;
        desc = "Open harpoon window";
      };
    }
    {
      key = "<leader>a";
      mode = "n";
      action.__raw = ''
        function()
          require("harpoon"):list():add()
        end
      '';
      options = {
        silent = true;
        noremap = true;
        desc = "Add current file to the harpoon list";
      };
    }
    {
      key = "<M-p>";
      mode = "n";
      action.__raw = ''
        function()
          require("harpoon"):list():next()
        end
      '';
      options = {
        silent = true;
        noremap = true;
        desc = "Go to next buffer stored in harpoon list";
      };
    }
    {
      key = "<M-n>";
      mode = "n";
      action.__raw = ''
        function()
          require("harpoon"):list():prev()
        end
      '';
      options = {
        silent = true;
        noremap = true;
        desc = "Go to previous buffer stored in harpoon list";
      };
    }
    # Nvim-ufo for Fold
    {
      key = "K";
      mode = "n";
      action.__raw = ''
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end
      '';
      options = {
        silent = true;
        noremap = true;
        desc = "Pee[K] into the fold, if not hover";
      };
    }
    # None-ls formatting
    {
      key = "<leader>lf";
      mode = "n";
      action.__raw = ''
        function()
          vim.lsp.buf.format()
        end
      '';
      options = {
        silent = true;
        noremap = true;
        desc = "[l]SP [f]ormat whole document";
      };
    }
  ];
}
