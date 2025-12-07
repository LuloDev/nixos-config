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

      vim.opt.relativenumber = true
      vim.opt.number = true

      -- KEYMAPS

      -- oil
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil (parent dir)" })
      vim.keymap.set("n", "<leader>E", "<CMD>Oil --float<CR>", { desc = "Open Oil (floating)" })

      EOF
    '';

    plugins = lib.concatLists loadedPlugins;

  };
}
