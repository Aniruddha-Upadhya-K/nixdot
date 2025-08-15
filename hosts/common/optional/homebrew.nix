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
      "argoproj/homebrew-tap"    = inputs.homebrew-tap;
    };
    autoMigrate = true;
    mutableTaps = true;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
  };
}
