#FIXME: Move attrs that will only work on linux to nixos.nix
#FIXME: if pulling in homemanager for isMinimal maybe set up conditional for some packages
{
  lib,
  pkgs,
  hostSpec,
  ...
}:

assert lib.assertMsg (hostSpec.defaults.terminal != null) "default terminal emulator is not set";

let
  platform = if hostSpec.isDarwin then "darwin" else "nixos";
in
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common/host-config.nix"
    ])
    ./${platform}.nix
    ./zsh.nix
    ./nixvim
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fonts.nix
    ./git.nix
    ./${hostSpec.defaults.terminal}.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  inherit hostSpec;

  home = {
    username = lib.mkDefault hostSpec.username;
    homeDirectory = lib.mkDefault hostSpec.home;
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      # FLAKE = "$HOME/.config/nixdot";
      # SHELL = "zsh";
      # TERM = lib.mkDefault "xterm-256color";
      # TERMINAL = lib.mkDefault "${hostSpec.defaults.terminal}";
      # VISUAL = "${hostSpec.defaults.editor}";
      # EDITOR = "${hostSpec.defaults.editor}";
      # MANPAGER = "batman"; # see bat.nix
    };
    preferXdgDirectories = true; # whether to make programs use XDG directories whenever supported

  };

  home.packages = with pkgs; [
    # Packages that don't have custom configs go here
    btop # resource monitor
    coreutils # basic gnu utils
    curl
    eza # ls replacement
    dust # disk usage
    fd # better find
    fastfetch
    findutils # find
    fzf # fuzzy search
    jq # json pretty printer and manipulator
    nix-tree # nix package tree viewer
    ncdu # TUI disk usage
    pfetch # system info
    ripgrep # better grep
    tree # cli dir tree viewer
    units
    unzip # zip extraction
    wget # downloader
    yq-go # yaml pretty printer and manipulator
    zip # zip compression
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
