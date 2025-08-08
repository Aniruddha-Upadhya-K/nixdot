{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    gdb
    valgrind
    clangStdenv
    bear
  ];

  systemd.coredump.enable = false;
}
