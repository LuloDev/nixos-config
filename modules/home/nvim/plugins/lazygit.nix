{ pkgs, ... }:

[
  pkgs.vimPlugins.plenary-nvim
  {
    plugin = pkgs.vimPlugins.lazygit-nvim;

  }
]
