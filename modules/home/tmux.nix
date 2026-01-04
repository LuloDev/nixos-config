{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      set-option -g status-position top
    '';
  };
}
