{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.aio;
in {
  options = { modules.homemanager.aio = { enable = mkEnableOption "aio"; }; };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ liquidctl gkraken ]; };

}
