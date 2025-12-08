{ pkgs, ... }:

## Plugin: lualine.nvim
## URL: https://github.com/nvim-lualine/lualine.nvim
## Description: A blazing fast and easy to configure Neovim statusline plugin.

[
  {
    plugin = pkgs.vimPlugins.lualine-nvim;

    config = ''
      lua << EOF

      -- Necesitas definir la función 'mode' que usas en lualine_a 
      -- si no está disponible globalmente. Una función simple para el modo sería:
      local function get_mode()
        local mode = vim.fn.mode()
        local modes = {
          n = "NORMAL",
          i = "INSERT",
          v = "VISUAL",
          V = "V-LINE",
          ['\22'] = "V-BLOCK",
          c = "COMMAND",
          R = "REPLACE",
          t = "TERM",
          s = "SELECT",
          S = "S-LINE",
          ['\19'] = "S-BLOCK",
        }
        return modes[mode] or mode
      end

      require('lualine').setup({
        options = {
          icons_enabled = true,
          section_separators = ' ', -- Usa un espacio si quieres un look más plano
          component_separators = ' ',
        },
        sections = {
          lualine_a = {
            {
              "mode", -- Display the current mode
              icon = "󱗞", -- Este ícono requiere fuentes Nerd Font
            },
          },
          -- Puedes añadir más secciones aquí si quieres
          lualine_b = { "filename" },
          lualine_c = { "diagnostics" },
          lualine_x = { "encoding", "fileformat" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = {
          "quickfix",
          {
            filetypes = { "oil" },
            sections = {
              lualine_a = {
                get_mode, -- Usamos la función definida arriba o "mode" si está disponible globalmente
              },
              lualine_b = {
                function()
                  local ok, oil = pcall(require, "oil")
                  if not ok then
                    return ""
                  end

                  -- La función 'mode' que usaste en tu configuración no estaba definida, 
                  -- por eso la reemplazo por get_mode si quieres el modo aquí, 
                  -- o simplemente la eliminas si quieres que 'lualine_a' maneje el modo.
                end,
              },
              lualine_c = {
                function()
                  local ok, oil = pcall(require, "oil")
                  if not ok then
                    return ""
                  end

                  -- Obtiene y muestra la ruta del directorio actual de Oil
                  -- vim.fn.fnamemodify(path, ":~") convierte la ruta a una ruta relativa al $HOME
                  local path = vim.fn.fnamemodify(oil.get_current_dir(), ":~")
                  return "󰉓 " .. path -- Añadimos un ícono de carpeta
                end,
              },
            },
          },
        },
      })
      EOF
    '';
  }
]
