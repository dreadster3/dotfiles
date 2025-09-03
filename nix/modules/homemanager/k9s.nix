{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.k9s;
in {
  options = { modules.homemanager.k9s = { enable = mkEnableOption "k9s"; }; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kubectl ];
    programs.k9s.enable = true;
  };
}
