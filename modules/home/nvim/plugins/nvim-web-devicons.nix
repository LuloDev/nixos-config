{ pkgs, ... }:

# Plugin: nvim-web-devicons
# URL: https://github.com/nvim-tree/nvim-web-devicons
# Description:  Provides Nerd Font icons (glyphs) for use by neovim plugins.

[
  {
    plugin = pkgs.vimPlugins.nvim-web-devicons;
  }
]
