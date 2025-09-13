{ pkgs, ... }: 

{
  programs.tmux = {
    enable = true;

    # Base index for windows & panes
    baseIndex = 1;

    clock24 = true;

    # Disable confirmation on window & session close
    disableConfirmationPrompt = true;

    # Enable Vi keybinding
    keyMode = "vi";

    # Enable mouse control
    mouse = true;

    # Change prefix to Ctrl-s
    shortcut = "s";

    # Set the $TERM variable
    terminal = "screen-256color";

    # Enable tmuxinator
    tmuxinator.enable = true;

    # Plugins
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator

      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }

      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"

          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_default_text " #W"

          # set -g @catppuccin_window_left_separator "█"
          # set -g @catppuccin_window_middle_separator "█"
          # set -g @catppuccin_window_right_separator "█"

          # set -g @catppuccin_status_left_separator " "
          # set -g @catppuccin_status_middle_separator " █"
          # set -g @catppuccin_status_right_separator "█"
          # set -g @catppuccin_status_background "#202020"
          set -g @catppuccin_status_connect_separator "yes"

          set -g status-left-length "100"
          set -g status-right-length "100"
          set -g status-left ""
          set -g  status-right "#{E:@catppuccin_status_directory}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set-option -g status-position top
        '';
      }
    ];

    extraConfig = ''
      set -g renumber-windows on

      # Source tmux config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      
      # Copy to clipboard
      setw -g mode-keys vi
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -sel clip -i"
      bind P paste-buffer
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -sel clip -i"
      
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
        
      # Switch panes with Ctrl-arrow
      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key k select-pane -U
      bind-key j select-pane -D

      # Sessionizer
      bind Space display-popup -E "tms"
      bind e display-popup -E "tms switch"
    '';
  };
}
