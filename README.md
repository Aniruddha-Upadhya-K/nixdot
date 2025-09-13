# My Dev Setup

This is my everyday NixOS/Nix-darwin setup. Look into [EmergentMinds's config](https://github.com/EmergentMind/nix-config) to understand more on the structure, as this is heavily inspired by that config, and feel free to copy anything and everything.

## Info:

### NixOS setup
- Window Manager: Hyprland
- Terminal Emulator: Kitty
- Shell: ZSH
- Editor: Neovim (configured via Nixvim)
- Dev Environment: tmux (with tms) and direnv
- Browser: Zen
- Greeter: Greetd
- Launcher: Rofi (Yet to style)
- Others: Waybar 

### Nix-Darwin Setup
- Window Manager: Aerospace
- Terminal Emulator: Kitty 
- Shell: ZSH
- Editor: Neovim (configured via Nixvim)
- Dev Environment: tmux (with tms) and direnv
- Browser: Zen
- Launcher: Choose-gui (as Spotlight can not be configured in any way and has useless features if you ask me)
- Others: Homebrew, Kanata (homerow mod for max keyboard, and partial desktop like keyboard setup)

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

Copy your existing hardware-configuration.nix and configuration.nix as default.nix to your host directory (NixOS only, skip this for Nis-darwin)
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
nh dawin switch ~/.config/nixdot -H <your-host-name>
```

### A Note on Nix-Darwin

Not everything work with just switching to this configuration. Few things like Kanata, Aerospace, Kitty, Syncthing etc needs permissions to be given.

If you can not find the application you wanted to give permission to, and the application does not appear to be listed in `/Applications`, you can get those applications in `/etc/profiles/per-user/<user>/bin/`. To find that path in Finder (A garbage if you ask me), press `cmd+shift+G` to open goto menu

For some reason, media keys (the ones on top of function keys) doesnt work after kanata was added to launchd, volume keys I got it to work but with Super (cmd-option-cntrl, set up to left option key to match desktop keyboard) modifier, rest are not working...

### Special Thanks to

- [EmergentMind](https://github.com/EmergentMind)
- [vimjoyer](https://github.com/vimjoyer)
