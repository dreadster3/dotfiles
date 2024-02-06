{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.aio;
in {
  options = { modules.aio = { enable = mkEnableOption "aio"; }; };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ liquidctl gkraken ]; };

}
