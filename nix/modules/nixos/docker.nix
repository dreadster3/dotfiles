{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.docker;
in {
  options = {
    modules.nixos.docker = {
      enable = mkEnableOption "docker";
      package = mkOption {
        type = types.package;
        default = pkgs.docker;
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      package = cfg.package;
    };
  };
}
