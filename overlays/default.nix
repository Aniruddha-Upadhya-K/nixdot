# This file defines overlays/custom modifications to upstream packages
#

{ inputs, ... }:

let
  # Adds my custom packages
  # FIXME: Add per-system packages
  # additions =
  #   final: prev:
  #   (prev.lib.packagesFromDirectoryRecursive {
  #     callPackage = prev.lib.callPackageWith final;
  #     directory = ../pkgs/common;
  #   });

  # linuxModifications = final: prev: prev.lib.mkIf final.stdenv.isLinux { };

  # modifications = final: prev: {
  # example = prev.example.overrideAttrs (oldAttrs: let ... in {
  # ...
  # });
  #    flameshot = prev.flameshot.overrideAttrs {
  #      cmakeFlags = [
  #        (prev.lib.cmakeBool "USE_WAYLAND_GRIM" true)
  #        (prev.lib.cmakeBool "USE_WAYLAND_CLIPBOARD" true)
  #      ];
  #    };
  # };

  stable-packages = final: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
      #      overlays = [
      #     ];
    };
  };

  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs {
      inherit (final) system;
      # config.allowUnfree = true;
      #      overlays = [
      #     ];
    };
  };

  # gtk-fix = final: prev: {
  #   gtk3 =
  #     (import inputs.nixpkgs-pinned-gtk3 {
  #       system = prev.system;
  #       config.allowUnfree = true;
  #     }).gtk3;
  # };

in {
  default = final: prev:

    # (additions final prev)
    # (modifications final prev)
    # (linuxModifications final prev)
    (stable-packages final prev)
    # // (gtk-fix final prev)
    // (unstable-packages final prev);
}
