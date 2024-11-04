{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.direnv;
in {
  options = {
    modules.homemanager.direnv = {
      enable = mkEnableOption "direnv";
      package = mkOption {
        type = types.package;
        default = pkgs.direnv;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
