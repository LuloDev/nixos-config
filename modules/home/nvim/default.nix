{
  pkgs,
  lib,
  ...
}:

let
  pluginsList = builtins.attrValues (builtins.readDir ./plugins);
  loadedPlugins = builtins.map (
    name: (import (./plugins + "/${name}") { inherit pkgs; })
  ) pluginsList;
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = lib.concatLists loadedPlugins;

    # extraConfig = "...";
  };
}
