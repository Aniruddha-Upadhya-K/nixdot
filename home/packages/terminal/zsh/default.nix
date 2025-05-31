{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
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
    };
    historySubstringSearch = {
      enable = true;
      searchDownKey = [ "^N" ];
      searchUpKey = [ "^P" ];
    };
    initContent = ''
      clear
      export PATH=$PATH:~/.local/bin/

      # Shell integrations
      eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/omp.toml)"
      eval "$(zoxide init --cmd cd zsh)"

      # Autosuggest
      ZSH_AUTOSUGGEST_USE_ASYNC="true"

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
      g = "git";
      ga = "git add";
      gaa = "git add .";
      gb = "git branch";
      gc = "git commit";
      gcm = "git commit --message";
      gco = "git checkout";
      gd = "git diff";
      gi = "git init";
      gp = "git pull";
      gs = "git status";
      nb = "nix-build";
      nd = "nix develop";
      nr = "nix run";
      ns = "nix-shell";
      nu = "nix-update";
      c = "clear";
      e = "exit";
      ls = "eza --icons always";
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
