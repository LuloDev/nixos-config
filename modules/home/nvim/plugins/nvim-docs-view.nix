{ pkgs, ... }:

## Plugin: nvim-docs-view
## URL: https://github.com/amrbashir/nvim-docs-view
## Description: A Neovim plugin for viewing documentation.
[
  {
    plugin = pkgs.vimPlugins.nvim-docs-view;

    config = ''
      lua << EOF
      require('docs-view').setup({
        position = "right",
        width = 60,
      })
      EOF
    '';
  }
]
