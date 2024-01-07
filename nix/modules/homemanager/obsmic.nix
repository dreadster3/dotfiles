{ config, lib, pkgs, ... }:
with lib;
let
  package = pkgs.callPackage ../../derivations/obsmic.nix { };
  cfg = config.modules.obsmic;
in {
  options = { modules.obsmic = { enable = mkEnableOption "obsmic"; }; };

  config = mkIf cfg.enable { home.packages = with pkgs; [ (package) ]; };
}
