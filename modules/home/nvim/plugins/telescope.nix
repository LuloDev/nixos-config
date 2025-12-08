{ pkgs, ... }:

[
  pkgs.vimPlugins.plenary-nvim
  pkgs.vimPlugins.telescope-fzf-native-nvim
  {
    plugin = pkgs.vimPlugins.telescope-nvim;

    config = ''
      lua << EOF
      require('telescope').setup({
        defaults = {
          -- Otras opciones de Telescope
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 120,
            },
          },
        },
      })
      EOF
    '';
  }
]
