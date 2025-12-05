{ pkgs, ... }:

# Plugin: fzf-lua
# URL: https://github.com/ibhagwan/fzf-lua
# Description: General-purpose command-line fuzzy finder.

[
  {
    plugin = pkgs.vimPlugins.fzf-lua;
  }
]
