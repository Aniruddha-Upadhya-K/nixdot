{ inputs, pkgs, ... }:
{
  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        featureShuffle
        songStats
        betterGenres
        beautifulLyrics
      ];
      enabledSnippets = with spicePkgs.snippets; [
        fixMainViewWidth
        newHoverPanel
        hideMadeForYou
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
        localFiles
      ];
    };
}
