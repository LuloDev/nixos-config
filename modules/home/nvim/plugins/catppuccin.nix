{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.catppuccin-nvim;
    config = ''
      lua << EOF
      require('catppuccin').setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        term_colors = true,
      })
      EOF

      colorscheme catppuccin
    '';
  }
]
