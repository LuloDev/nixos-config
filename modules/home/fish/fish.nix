{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    functions = {
      dev = {
        body = ''
          if tmux has-session -t dev 2>/dev/null
            tmux attach-session -t dev
          else
            tmux new-session -d -s dev -n nvim 'nvim'
            tmux new-window -t dev -n shell
            tmux attach-session -t dev
          end
        '';
      };
    };

    
    
  };
}
