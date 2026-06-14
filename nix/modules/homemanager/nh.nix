{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.nh;
in
{
  options = {
    modules.homemanager.nh = {
      enable = mkEnableOption "nh";
      package = mkOption {
        type = types.package;
        default = pkgs.nh;
      };
      flake = mkOption {
        type = types.str;
        default = "${config.home.homeDirectory}/Documents/projects/github/dotfiles/nix";
        description = "Flake path used by nh";
      };
    };
  };
  config = mkIf cfg.enable {
    programs.nh = {
      inherit (cfg) package;
      flake = cfg.flake;

      enable = true;
    };
  };
}
