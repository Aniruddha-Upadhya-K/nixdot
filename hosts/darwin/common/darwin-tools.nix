{ config, lib, isDarwin, ... }:

assert lib.assertMsg isDarwin "importing homebrew in non-macos system";

{
  homebrew = {
    taps = [
      "devsunb/tap"
    ];
    brews = lib.flatten [ 
      (lib.optional (config.hostSpec.desktopEnv == "aerospace") [
        config.hostSpec.defaults.launcher.app
      ])

      "kanata-vk-agent"
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
