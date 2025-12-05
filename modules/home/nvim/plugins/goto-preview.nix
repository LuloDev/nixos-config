{ pkgs, ... }:

# Plugin: goto-preview
# URL: https://github.com/rmagatti/goto-preview
# Description: Provides preview functionality for definitions, declarations, implementations, type definitions, and references.

[
  {
    plugin = pkgs.vimPlugins.goto-preview;
  }
]
