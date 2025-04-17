{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.flameshot;
in {
  options = {
    modules.homemanager.flameshot = {
      enable = mkEnableOption "flameshot";
      package = mkOption {
        type = with pkgs; types.package;
        default = pkgs.flameshot;
      };
    };
  };

  config = mkIf cfg.enable {
    services.sxhkd.keybindings = { "Print" = "${getExe cfg.package} gui"; };

    services.flameshot = {
      inherit (cfg) package;

      enable = true;
    };
  };
}
