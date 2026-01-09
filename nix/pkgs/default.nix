# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, inputs, ... }:
{
  x11eventcallbacks = pkgs.callPackage ./x11eventcallbacks.nix { };
  mechvibes = pkgs.callPackage ./mechvibes.nix { };
  spicetify_theme = pkgs.callPackage ./spicetify_theme.nix { };
  vivid-glassy-dark-icons = pkgs.callPackage ./vivid-glassy-dark-icons.nix { };
  spicetifyPackages = inputs.spicetify.legacyPackages.${pkgs.system};
}
