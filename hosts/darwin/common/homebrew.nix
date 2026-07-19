{ inputs, config, ... }:

{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = config.hostSpec.username;
    taps = {
      "homebrew/homebrew-core"   = inputs.homebrew-core;
      "homebrew/homebrew-cask"   = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    autoMigrate = true;
    mutableTaps = true;

    # Optional: Declarative Homebrew tap trust entries.
    #
    # Note: The trust entries are _not_ removed if you remove them from those lists!
    # Use the `brew untrust` command to remove a trust entry.
    trust = {
      formulae = [ ];
      casks = [ "mediosz/tap/swipeaerospace" ];
      commands = [ ];
      taps = [ ];
    };
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
  };
}
