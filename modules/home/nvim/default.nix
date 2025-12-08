{
  pkgs,
  lib,
  ...
}:

let
  pluginsNames = builtins.attrNames (builtins.readDir ./plugins);

  nixPluginsNames = lib.filter (name: lib.hasSuffix ".nix" name) pluginsNames;

  loadedPlugins = builtins.map (
    name: (import (./plugins + "/${name}") { inherit pkgs; })
  ) nixPluginsNames;

in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    extraConfig = ''
      lua << EOF
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      vim.opt.clipboard = "unnamedplus"

      vim.opt.relativenumber = true
      vim.opt.number = true

      -- KEYMAPS
      local builtin = require('telescope.builtin')

      -- === Mapeos de Búsqueda (Reemplazo de Snacks) ===

      -- Comandos principales
      vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = "Smart Find Files" })
      vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = "Buffers" })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = "Grep (Buscar texto)" })
      vim.keymap.set('n', '<leader>:', builtin.command_history, { desc = "Command History" })
      --vim.keymap.set('n', '<leader>n', builtin.notify, { desc = "Notification History" }) 

      -- Mapeo de Explorador (se recomienda usar Oil, ya configurado)
      vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = "File Explorer (Oil)" })

      -- Categoría 'find' (<leader>f...)
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
      vim.keymap.set('n', '<leader>fc', function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Find Git Files" })
      --vim.keymap.set('n', '<leader>fp', builtin.projects, { desc = "Projects (Requiere plugin projects)" })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent Files" })

      -- Búsqueda de Contenido y Archivos
      vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = "Buffer Lines" }) -- Buffer Lines
      vim.keymap.set('n', '<leader>sB', builtin.grep_string, { desc = "Grep Open Buffers" }) -- Buscar la palabra bajo el cursor en buffers abiertos
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = "Grep (Buscar texto)" }) -- Grep en archivos
      vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end, { desc = "Grep Word" }) -- Buscar palabra o selección

      -- Historiales y Registros
      vim.keymap.set('n', '<leader>s"', builtin.registers, { desc = "Registers" })
      vim.keymap.set('n', '<leader>s/', builtin.search_history, { desc = "Search History" })
      vim.keymap.set('n', '<leader>sc', builtin.command_history, { desc = "Command History" })
      vim.keymap.set('n', '<leader>sj', builtin.jumplist, { desc = "Jumps" })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = "Keymaps" })
      vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = "Marks" })
      vim.keymap.set('n', '<leader>sM', builtin.man_pages, { desc = "Man Pages" })
      vim.keymap.set('n', '<leader>sR', builtin.resume, { desc = "Resume Last Search" })
      --vim.keymap.set('n', '<leader>su', builtin.undo, { desc = "Undo History" })

      -- Listas de Estado y Debug
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = "Diagnostics" })
      vim.keymap.set('n', '<leader>sD', function() builtin.diagnostics({ bufnr = 0 }) end, { desc = "Buffer Diagnostics" })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = "Help Pages" })
      vim.keymap.set('n', '<leader>sl', builtin.loclist, { desc = "Location List" })
      vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = "Quickfix List" })
      vim.keymap.set('n', '<leader>uC', builtin.colorscheme, { desc = "Colorschemes" })

      -- Utilidades (sin reemplazo directo en Telescope)
      -- Los mapeos para Autocmds, Highlights, Icons, Lazy, Plugin Spec no tienen un equivalente 1:1 en Telescope


      -- === Mapeos de LSP (Language Server Protocol) ===

      -- Estos comandos usan las funciones de Telescope que interactúan con el LSP
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = "Goto Definition" })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Goto Declaration" }) -- Usar función nativa de Neovim
      vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "References" })
      vim.keymap.set('n', 'gI', builtin.lsp_implementations, { desc = "Goto Implementation" })
      vim.keymap.set('n', 'gy', builtin.lsp_type_definitions, { desc = "Goto Type Definition" })

      -- Símbolos
      vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = "LSP Symbols" })
      vim.keymap.set('n', '<leader>sS', builtin.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })

      -- Llamadas LSP (Incoming/Outgoing Calls): Requiere extensiones de Telescope o un plugin LSP más avanzado.
      -- Por ahora, se omiten ya que no tienen un 'builtin' directo.

      -- === Otros Mapeos (Reemplazo de Snacks) ===

      -- Terminal: Reemplazado por una función simple
      local toggle_terminal = function() vim.cmd("toggleterm") end -- Asumiendo que usas toggleterm.nvim
      vim.keymap.set({ 'n', 't' }, '<C-/>', toggle_terminal, { desc = "Toggle Terminal" })
      vim.keymap.set({ 'n', 't' }, '<C-_>', toggle_terminal, { desc = "which_key_ignore" })

      -- oil
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil (parent dir)" })
      vim.keymap.set("n", "<leader>E", "<CMD>Oil --float<CR>", { desc = "Open Oil (floating)" })

      -- lazyvim
      vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })

      EOF
    '';

    plugins = lib.concatLists loadedPlugins;

  };
  home.packages = with pkgs; [
    nil # Nix
    nixfmt-rfc-style # Formateador para Nix (opcional pero recomendado)
    pyright # Python
    typescript-language-server # Javascript / Typescript
    vscode-langservers-extracted # HTML, CSS, JSON, ESLint
  ];
}
