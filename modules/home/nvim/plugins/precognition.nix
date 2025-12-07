{ pkgs, ... }:

# Plugin: precognition.nvim
# URL: https://github.com/tris203/precognition.nvim
# Description: Precognition uses virtual text and gutter signs to show available motions.

[
  {
    plugin = pkgs.vimPlugins.precognition-nvim;
  }
]
