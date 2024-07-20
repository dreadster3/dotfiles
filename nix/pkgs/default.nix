# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  x11eventcallbacks = pkgs.callPackage ./x11eventcallbacks.nix { };
  mechvibes = pkgs.callPackage ./mechvibes.nix { };
  spicetify_theme = pkgs.callPackage ./spicetify_theme.nix { };
}
