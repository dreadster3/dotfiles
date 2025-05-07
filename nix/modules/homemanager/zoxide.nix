{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.zoxide;
in {
  options = {
    modules.homemanager.zoxide = {
      enable = mkEnableOption "zoxide";
      package = mkOption {
        type = types.package;
        default = pkgs.zoxide;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      inherit (cfg) package;
    };
  };
}

