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

    plugins = lib.concatLists loadedPlugins;

  };
}
