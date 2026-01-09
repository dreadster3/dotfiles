{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./vmware
    ./qemu
    ./waydroid.nix
  ];
}
