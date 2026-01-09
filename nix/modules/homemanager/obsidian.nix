{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.obsidian;
in
{
  options = {
    modules.homemanager.obsidian = {
      enable = mkEnableOption "obsidian";
      package = mkOption {
        type = types.package;
        default = pkgs.obsidian;
      };
    };
  };
  config = mkIf cfg.enable {
    programs.obsidian = {
      enable = true;
      vaults = {
        personal = {
          target = "${config.xdg.dataHome}/obsidian/vaults/personal";
        };
      };
    };
  };
}
