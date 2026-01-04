{ pkgs, ... }:
{
  catppuccin.flavor = "macchiato";
  catppuccin.enable = true;
  
  catppuccin.tmux.enable = true;
  catppuccin.tmux.extraConfig = ''
      set -g @catppuccin_window_status_style "rounded"
      set -g @catppuccin_window_number_position "right"
      
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W" # Muestra el nombre del proceso (nvim, fish, etc)

      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W"

      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"

      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"

      set -g @catppuccin_directory_text "#{pane_current_path}"  '';
}
