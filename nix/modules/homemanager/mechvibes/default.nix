{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.homemanager.mechvibes;
  mechvibes = pkgs.callPackage ./derivation.nix { };
in {
  options = {
    modules.homemanager.mechvibes = { enable = mkEnableOption "mechvibes"; };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ (final: prev: { mechvibes = mechvibes; }) ];

    xsession.windowManager.bspwm.startupPrograms =
      [ "${pkgs.mechvibes}/bin/mechvibes --disable-seccomp-filter-sandbox" ];

    home.packages = with pkgs; [ mechvibes ];
    programs.zsh.shellAliases.mechvibes =
      "mechvibes --disable-seccomp-filter-sandbox";
  };

}
