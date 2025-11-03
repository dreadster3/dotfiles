{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.git;
in {
  options = {
    modules.homemanager.git = {
      enable = mkEnableOption "git";
      package = mkOption {
        type = types.package;
        default = pkgs.git;
      };
      username = mkOption {
        type = types.str;
        default = config.home.username;
      };
      email = mkOption { type = types.str; };
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          inherit (cfg) email;
          name = cfg.username;
        };
      };
    };
  };
}
