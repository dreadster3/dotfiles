# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev:
    import ../pkgs {
      inherit inputs;
      inherit (final) pkgs;
    };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: _prev: {
    quickshell = inputs.quickshell.packages."${final.system}".default;
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  unstable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
