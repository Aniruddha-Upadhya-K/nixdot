# git is core no matter what but additional settings may could be added made in optional/foo   eg: development.nix
{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    userName = config.hostSpec.handle;
    userEmail = config.hostSpec.email;

    ignores = [
      ".csvignore"
      # nix
      "*.drv"
      "result"
      # python
      "*.py?"
      "__pycache__/"
      ".venv/"
      # direnv
      ".direnv"
      # javascript
      "node_modules/"
    ];

    extraConfig = {
      core.pager = "delta";
      delta = {
        enable = true;
        features =
          [ "side-by-side" "line-numbers" "hyperlinks" "commit-decoration" ];
      };

      extraConfig = {
        init.defaultBranch = "main";
        pull.ff = "only";
        status = {
          branch = true;
          showStash = true;
          showUntrackedFiles = "all"; # show individual untracked files
        };
        push = {
          autoSetupRemote = true; # easier to push new branches
          default = "current"; # push only current branch by default
        };
        core = {
          editor = "nvim";
          preloadIndex = true;
        };
        diff = { tool = "nvimdiff"; };
        log = { abbrevCommit = true; };
        merge = { tool = "nvimdiff"; };
      };

      # pre-emptively ignore mac crap
      core.excludeFiles = builtins.toFile "global-gitignore" ''
        .DS_Store
        .DS_Store?
        ._*
        .Spotlight-V100
        .Trashes
        ehthumbs.db
        Thumbs.db
        node_modules
      '';

      core.attributesfile = builtins.toFile "global-gitattributes" ''
        Cargo.lock -diff
        flake.lock -diff
        *.drawio -diff
        *.svg -diff
        *.json diff=json
        *.bin diff=hex difftool=hex
        *.dat diff=hex difftool=hex
        *aarch64.bin diff=objdump-aarch64 difftool=objdump-aarch64
        *arm.bin diff=objdump-arm difftool=objdump-arm
        *x64.bin diff=objdump-x86_64 difftool=objdump-x64
        *x86.bin diff=objdump-x86 difftool=objdump-x86
      '';
      # Makes single line json diffs easier to read
      diff.json.textconv = "jq --sort-keys .";
    };
  };
}
