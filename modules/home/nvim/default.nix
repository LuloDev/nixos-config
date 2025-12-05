{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = catppuccin-nvim;
        config = ''
          " Configuración Lua para catppuccin
          lua << EOF
          require('catppuccin').setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            term_colors = true,
          })
          EOF

          " Aplicar el esquema de color
          colorscheme catppuccin
        '';
      }
    ];
  };
}
