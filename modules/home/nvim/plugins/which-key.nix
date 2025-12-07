{ pkgs, ... }:

## Plugin: folke/which-key.nvim
## URL: https://github.com/folke/which-key.nvim
## Description: Plugin to show a popup with available keybindings.
[
  {
    plugin = pkgs.vimPlugins.which-key-nvim;
  }
]
