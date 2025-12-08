{ pkgs, ... }:

## Plugin: incline.nvim
## URL: https://github.com/b0o/incline.nvim
## Description: A Neovim plugin for showing the current filename in a floating window.

[
  {
    plugin = pkgs.vimPlugins.incline-nvim;

    config = ''
      lua << EOF
      require("incline").setup({
        window = { 
          margin = { vertical = 0, horizontal = 1 } 
        },
        
        hide = {
          cursorline = true,
        },
        
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t") 
          
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename 
          end

          local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
          local icon, color = devicons_ok and devicons.get_icon_color(filename) or { "", nil }
          
          return { 
            { icon, guifg = color }, 
            { " " }, 
            { filename } 
          } 
        end,
      })
      EOF
    '';
  }
]
