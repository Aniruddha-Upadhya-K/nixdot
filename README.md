# My Dev Setup

This is my everyday NixOS/Nix-Darwin setup. Look into [EmergentMinds's config](https://github.com/EmergentMind/nix-config) to understand more on the structure, as this is heavily inspired by that config, and feel free to copy anything and everything.

## Info:

### NixOS setup
- Window Manager: Hyprland
- Terminal Emulator: kitty
- Shell: zsh
- Editor: neovim (configured via Nixvim)
- Dev Environment: tmux (with tms) and direnv
- Browser: Zen
- Greeter: Greetd
- Launcher: Rofi (Yet to style)
- Others: Waybar 

(yet to attach NixOS screenshots)

### Nix-Darwin Setup
- Window Manager: Aerospace
- Terminal Emulator: kitty 
- Shell: zsh
- Editor: neovim (configured via Nixvim)
- Dev Environment: tmux (with tms) and direnv
- Browser: Zen
- Launcher: choose-gui (as Spotlight can not be configured in any way and has useless features if you ask me)
- Others: Homebrew, Kanata (homerow mod for max keyboard, and partial desktop like keyboard setup)

![mac terminal](/assets/mac-terminal.webp)

## Installation

Prerequisites:
- [Working NixOS machine](https://nixos.org/manual/nixos/stable/index.html#ch-installation) (for NixOS)
- [working Nix-Darwin](https://github.com/nix-darwin/nix-darwin) (For Nix-Darwin)
- [Flake enables](https://nixos.wiki/wiki/flakes)

Clone and cd into the repo
``` bash
git clone https://github.com/Aniruddha-Upadhya-K/nixdot.git ~/.config/nixdot && cd ~/.config/nixdot
```

Make a host entry for your device
``` bash
mkdir ./hosts/nixos/<you-host-name>
```

Copy your existing hardware-configuration.nix and configuration.nix as default.nix to your host directory (NixOS only, skip this for Nis-Darwin)
``` bash
cp /etc/nixos/hardware-configuration.nix ./hosts/nixos/<your-host-name>/
```

Import required modules from `./hosts/common/` in your configuration file, and setup `hostSpec`, follow `./hosts/nixos/aspire/default.nix` for inspiration.

Similarly create User by making a directory in `./home/`. For more detailed explanation on how to create your own host, and user head on to [EmergentMind's config](https://github.com/EmergentMind/nix-config).

To build the configuration,

for NixOS
``` bash
nh os switch ~/.config/nixdot -H <your-host-name>
```

for Nix-darwin
``` bash
nh darwin switch ~/.config/nixdot -H <your-host-name>
```

### A Note on Nix-Darwin

Not everything works immediately after switching to this config. Some apps (Kanata, Aerospace, Kitty, Syncthing) need additional permissions.

If an app doesn’t show up in /Applications, you can usually find it in /etc/profiles/per-user/<user>/bin/. To open this path in Finder, use cmd+shift+G.

Media keys are partially broken after adding Kanata to launchd. Volume works with the Super modifier (cmd+option+ctrl mapped to left option), but other media keys remain unresponsive.

### Special Thanks to

- [EmergentMind](https://github.com/EmergentMind)
- [vimjoyer](https://github.com/vimjoyer)
