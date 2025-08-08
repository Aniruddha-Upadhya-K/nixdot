#FIXME: Move attrs that will only work on linux to nixos.nix
#FIXME: if pulling in homemanager for isMinimal maybe set up conditional for some packages
{
  config,
  lib,
  pkgs,
  hostSpec,
  ...
}:
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

  services.ssh-agent.enable = true;

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      FLAKE = "$HOME/.config/nixdot";
      SHELL = "zsh";
      TERM = lib.mkDefault "${hostSpec.defaults.terminal}";
      TERMINAL = lib.mkDefault "${hostSpec.defaults.terminal}";
      VISUAL = "${hostSpec.defaults.editor}";
      EDITOR = "${hostSpec.defaults.editor}";
      MANPAGER = "batman"; # see bat.nix
    };
    preferXdgDirectories = true; # whether to make programs use XDG directories whenever supported

  };
  #TODO(xdg): maybe move this to its own xdg.nix?
  # xdg packages are pulled in below
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/.desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/media/audios";
      pictures = "${config.home.homeDirectory}/media/images";
      videos = "${config.home.homeDirectory}/media/videos";
      publicShare = "/var/empty"; #using this option with null or "/var/empty" barfs so it is set properly in extraConfig below
      templates = "/var/empty"; #using this option with null or "/var/empty" barfs so it is set properly in extraConfig below

      extraConfig = {
        # publicshare and templates defined as null here instead of as options because
        XDG_PUBLICSHARE_DIR = "/var/empty";
        XDG_TEMPLATES_DIR = "/var/empty";
      };
    };
  };

  home.packages = with pkgs; [
    # Packages that don't have custom configs go here
    btop # resource monitor
    coreutils # basic gnu utils
    curl
    eza # ls replacement
    dust # disk usage
    fd # tree style ls
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
    wev # show wayland events. also handy for detecting keypress codes
    wget # downloader
    xdg-utils # provide cli tools such as `xdg-mime` and `xdg-open`
    xdg-user-dirs
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
