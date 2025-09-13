{ pkgs, lib, isDarwin, ... }:
let
  option = if !isDarwin then {
    systemd.coredump.enable = false;
  } else {
    # homebrew = {
      # taps = [
      #   "LouisBrunner/valgrind"
      # ];

      # brews = [
      #   {
      #     name = "LouisBrunner/valgrind/valgrind";
      #     args = [ "--HEAD" ];
      #   }
      # ];
    # };
  };
in 
{
  environment.systemPackages = lib.flatten (with pkgs; [
    gcc
    gnumake
    cmake
    gdb
    clang-tools
    bear

    (lib.optional (!isDarwin) [
      valgrind # does not work in mac
    ])
  ]);
} // option
