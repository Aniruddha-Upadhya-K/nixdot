{ pkgs, config, ... }: 

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;

    # Change prefix to Ctrl-s
    shortcut = "s";

    # Plugins
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      vim-tmux-navigator
      online-status
      battery
    ];

    extraConfig = ''
    # Enable mouse control
    set -g mouse on
    
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
      
      # Fix color support
      set-option -sa terminal-overrides ',xterm-256color:RGB'
      set -g default-terminal "tmux"
      
      
      # Catppuccin Theme Configuration
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "slanted"
      set -g @catppuccin_window_number_position "left"
      
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"
      
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W"
      
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"
      
      set -g @catppuccin_directory_text "#{pane_current_path}"
      
      set -g @catppuccin_status_background "#202020"
      
      set -g status-left-length "100"
      set -g status-right-length "100"
      
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_directory}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      
      set-option -g status-position top

      # bootstrap tpm
      if "test ! -d ~/.tmux/plugins/tpm" \
      "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'
      '';
  };
}
