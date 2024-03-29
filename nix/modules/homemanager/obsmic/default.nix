{ config, lib, pkgs, ... }:
with lib;
let
  package = pkgs.callPackage ./derivation.nix { };
  cfg = config.modules.homemanager.obsmic;
in {
  options = {
    modules.homemanager.obsmic = { enable = mkEnableOption "obsmic"; };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ (package) ]; };
}
