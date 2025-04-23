{ config, pkgs, inputs, system, ... }:

{
  home.packages = [ inputs.zen-browser.packages."${system}".default ];
}
