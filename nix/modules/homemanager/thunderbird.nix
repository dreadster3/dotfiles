{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.thunderbird;
in {
  options = {
    modules.thunderbird = { enable = mkEnableOption "thunderbird"; };
  };

  config = mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;
      profiles = { default = { isDefault = true; }; };
    };
  };
}
