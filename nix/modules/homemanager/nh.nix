{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.homemanager.nh;

  flake = "${config.home.homeDirectory}/Documents/projects/github/dotfiles/nix";
in {
  options = {
    modules.homemanager.nh = {
      enable = mkEnableOption "nh";
      package = mkOption {
        type = types.package;
        default = pkgs.nh;
      };
    };
  };
  config = mkIf cfg.enable {
    home.sessionVariables = { NH_FLAKE = flake; };

    programs.nh = {
      inherit (cfg) package;
      inherit flake;

      enable = true;
    };
  };
}
