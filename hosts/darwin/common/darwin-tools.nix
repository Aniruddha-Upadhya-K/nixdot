{ config, lib, isDarwin, ... }:

assert lib.assertMsg isDarwin "importing homebrew in non-macos system";

{
  homebrew = {
    brews = lib.flatten [ 
      (lib.optional (config.hostSpec.desktopEnv == "aerospace") [
        config.hostSpec.defaults.launcher.app
      ])
    ];
    casks = lib.flatten [
      # essentials
      "middleclick"
      "karabiner-elements"
      "sanesidebuttons"
      "unnaturalscrollwheels"
      "openmtp"

      # media
      "obs"
      "gimp"
      "blender"

      (lib.optional (config.hostSpec.desktopEnv == "aerospace") [
        "swipeaerospace" 
      ])
    ];
  };
}
