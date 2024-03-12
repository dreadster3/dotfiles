{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.thunderbird;
in {
  options = {
    modules.homemanager.thunderbird = {
      enable = mkEnableOption "thunderbird";
    };
  };

  config = mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;
      profiles = { default = { isDefault = true; }; };
    };
  };
}
