# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, inputs, ... }:
{
  x11eventcallbacks = pkgs.callPackage ./x11eventcallbacks.nix { };
  mechvibes = pkgs.callPackage ./mechvibes.nix { };
  open-webui-desktop = pkgs.callPackage ./open-webui-desktop.nix { };

  # Custom themes for turing-smart-screen-python, auto-generated from ../configurations/turing-smart-screen/themes
  tssp-custom-themes = pkgs.callPackage ./tssp-custom-themes.nix {
    themesDir = ../../configurations/turing-smart-screen/themes;
  };
}
