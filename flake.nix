{
  description = "Nixos config flake";
  outputs = { self, nixpkgs, nix-darwin, ... }@inputs:
    let
      inherit (self) outputs;
      # NOTE: This approach allows lib.custom to propagate into hm
      # see: https://github.com/nix-community/home-manager/pull/3454
      lib = nixpkgs.lib.extend
        (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
    in {
      # Custom modifications/overrides to upstream packages
      # overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs lib;
            isDarwin = false;
          };
          system = "x86_64-linux";
          modules = [ ./hosts/nixos/${host} ];
        };
      }) (builtins.attrNames (builtins.readDir ./hosts/nixos)));

      darwinConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit inputs outputs lib;
              isDarwin = true;
            };
            system = "aarch64-darwin";
            modules = [ ./hosts/darwin/${host} ];
          };
        }) (builtins.filter (name: name != "common") (builtins.attrNames (builtins.readDir ./hosts/darwin)))
      );
      
            #
      # ========= Packages =========
      #
      # Expose custom packages

      /*
        NOTE: This is only for exposing packages exterally; ie, `nix build .#packages.x86_64-linux.cd-gitroot`
        For internal use, these packages are added through the default overlay in `overlays/default.nix`
      */

      # forAllSystems = nixpkgs.lib.genAttrs [
        #"x86_64-linux"
        #"aarch64-darwin"
      #];


      # packages = forAllSystems (
      #   system:
      #   let
      #     pkgs = import nixpkgs {
      #       inherit system;
      #       overlays = [ self.overlays.default ];
      #     };
      #   in
      #   nixpkgs.lib.packagesFromDirectoryRecursive {
      #     callPackage = nixpkgs.lib.callPackageWith pkgs;
      #     directory = ./packages/common;
      #   }
      # );
    };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-tap = {
      url = "github:argoproj/homebrew-tap";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
  };
}
