{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.ollama;
in {
  options = {
    modules.homemanager.ollama = {
      enable = mkEnableOption "ollama";
      package = mkOption {
        type = types.package;
        default = pkgs.ollama;
      };
    };
  };
  config = mkIf cfg.enable { services.ollama = { enable = true; }; };
}
