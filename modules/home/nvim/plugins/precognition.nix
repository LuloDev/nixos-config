{ pkgs, ... }:

# Plugin: precognition.nvim
# URL: https://github.com/tris203/precognition.nvim
# Description: Precognition uses virtual text and gutter signs to show available motions.

[
  pkgs.vimPlugins.plenary-nvim
  {
    plugin = pkgs.vimPlugins.precognition-nvim;
    config = ''
      lua << EOF
      require('precognition').setup({
        
        diagnostic_icons = true, 

        delay = 100, 
      })
      EOF
    '';
  }
]
