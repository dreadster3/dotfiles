{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.spicetify;

in {

  options = {
    modules.spicetify = { enable = mkEnableOption "spicetify-cli"; };
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ spotify spicetify-cli ]; };
}
