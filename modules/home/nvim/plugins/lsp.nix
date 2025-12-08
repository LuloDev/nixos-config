{ pkgs, ... }:

[
  pkgs.vimPlugins.fidget-nvim
  {
    plugin = pkgs.vimPlugins.nvim-lspconfig;

    config = ''
      lua << EOF
      require("fidget").setup({})

      -- Hacemos require de lspconfig para asegurarnos que se inicialice
      -- Aunque esto pueda generar la advertencia, es necesario para la estabilidad.
      local lspconfig = require('lspconfig')

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local on_attach = function(client, bufnr)
        -- Parche de Semantic Tokens
        client.server_capabilities.semanticTokensProvider = nil
        
        local opts = { buffer = bufnr, noremap = true, silent = true }
        
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      end

      -- =======================================================
      -- CONFIGURACIÓN FINAL: DEFINICIÓN DE SERVIDORES
      -- =======================================================

      -- 1. Definimos una tabla de configuraciones
      local servers = {
          nil_ls = { settings = { ['nil'] = { formatting = { command = { "nixfmt" } } } } },
          pyright = {},
          ts_ls = {},
          html = {},
          cssls = {},
      }

      -- 2. ITERAMOS USANDO lspconfig.setup
      -- NOTA: Esto usa el método "obsoleto" (framework) que es el único que 
      -- garantiza la estabilidad de la carga en tu entorno actual.
      for name, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        
        -- Llamada que asegura que el servidor se configure correctamente
        lspconfig[name].setup(config) 
      end

      EOF
    '';
  }
]
