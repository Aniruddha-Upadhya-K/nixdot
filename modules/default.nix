{ config, pkgs, inputs, system, ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;

      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      # Enable nix flakes
      experimental-features = [ "nix-command" "flakes" ];

    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  imports = [
    ./env.nix
    ../scripts
    ./stylix.nix
    inputs.home-manager.nixosModules.default
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware = {
    bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket"; # Allow A2DP profile
          Experimental = true; # Show battery of the bluetooth devices
        };
      };
    };
  };

  services.blueman.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    oh-my-posh
    zoxide
    fzf
    tmux
    gcc
    gnumake
    clangStdenv
    nodejs
    python3
    jdk23
    cargo
    vlc
    blender
    ffmpeg
    (flameshot.override { enableWlrSupport = true; })
    grim
    btop
    tree
    fastfetch
    nemo
    networkmanagerapplet
    jq
    wl-screenrec
    gimp-with-plugins
    gthumb
    brave
    eza
    units
    pavucontrol # audio control
    bat

    # temp
    vscode
    jetbrains.idea-community-bin

    # HYPRLAND UTILS
    hyprland-qtutils
    font-awesome

    # Screen shot
    hyprshot
    satty

    # Clipboard
    wl-clipboard

    # Brightness control for Hyprland
    brightnessctl

    # Media control for Hyprland
    playerctl
  ];

  # services.grafana = {
  #   enable   = true;
  #   port     = 3000;
  #   domain   = "localhost";
  #   protocol = "http";
  #   dataDir  = "/var/lib/grafana";
  # };

  # Install Nix-ld to be able to run unpackaged binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs;
    [
      # Add any missing dynamic libraries for unpackaged
      # programs here, NOT in environment.systemPackages
    ];

  # Install firefox.
  programs.firefox.enable = true;

  # Install ZSH.
  programs.zsh.enable = true;

  # Install Docker.
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Install Hyprland and its dependancies/utils
  programs.hyprland = {
    enable = true;
    # set the flake package
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true; # recommended for most users
    xwayland.enable = true;
  };

  security.pam.services.hyprlock = { };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ani = {
    isNormalUser = true;
    description = "ani";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    home = "/home/ani";
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs system; };
    users = { "ani" = import ../home/home.nix; };
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
  };
}
