# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, inputs, ... }:
{
  x11eventcallbacks = pkgs.callPackage ./x11eventcallbacks.nix { };
  mechvibes = pkgs.callPackage ./mechvibes.nix { };
  open-webui-desktop = pkgs.callPackage ./open-webui-desktop.nix { };
}
