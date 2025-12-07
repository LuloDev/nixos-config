{ pkgs, ... }:

# Plugin: oil-nvim
# URL: https://github.com/stevearc/oil.nvim
# Description:   Neovim file explorer: edit your filesystem like a buffer

[
  {
    plugin = pkgs.vimPlugins.oil-nvim;
    config = ''
      lua << EOF
      require('oil').setup({
        default_file_explorer = false,
        columns = {
          "icon",
          "filename",
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, bufnr)
            return name == "store" or name == ".git"
          end,
        },
        
        keymaps = {
          ["<C-h>"] = "actions.select_split",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-t>"] = "actions.select_tab",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["."] = "actions.toggle_hidden",
        },
      })

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil (parent dir)" })
      vim.keymap.set("n", "<leader>E", "<CMD>Oil --float<CR>", { desc = "Open Oil (floating)" })

      EOF
    '';
  }
]
