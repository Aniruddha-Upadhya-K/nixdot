{ pkgs, hostSpec, ... }:

{
  home.packages = [ pkgs.oh-my-posh ];

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    dotDir = "${hostSpec.home}/.config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    completionInit = "autoload -Uz compinit && compinit";
    history = {
      append = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
      path = "${hostSpec.home}/.config/zsh/zsh_history";
    };
    historySubstringSearch = {
      enable = true;
      searchDownKey = [ "^N" ];
      searchUpKey = [ "^P" ];
    };
    sessionVariables = {
      KEYTIMEOUT = 40;
    };
    initContent = ''
      clear
      export PATH=$PATH:~/.local/bin/

      # Shell integrations
      # eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/omp.toml)"
      # eval "$(zoxide init --cmd cd zsh)"

      # Autosuggest
      ZSH_AUTOSUGGEST_USE_ASYNC="true"

      # Key bindings
      bindkey 'jk' vi-cmd-mode
      bindkey '^ ' autosuggest-accept   # ctrl+space

      # Group matches and describe.
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
      zstyle ':completion:*' special-dirs true

      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

      zstyle ':completion:*' menu yes select
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character
      zstyle ':completion:*' use-compctl false
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'

      # fzf-tab
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      # Fuzzy match mistyped completions.
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric

      # Don't complete unavailable commands.
      zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

      # Array completion element sorting.
      zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
    '';

    shellAliases = {
      cp = "cp -i";
      grep = "grep --color=auto";
      mv = "mv -i";
      ls = "eza --icons always";
      cat = "bat";
      diff = "batdiff";
      man = "batman";
      tmux = "tmux -u";
      btop = "btop --force-utf";

      # nix helper
      nixos-rebuild = "nh os";
      nix-collect-garbage = "nh clean";
    };

    plugins = with pkgs;
      [
        {
          name = "fzf-tab";
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
          src = zsh-fzf-tab;
        }
      ];
  };
}
