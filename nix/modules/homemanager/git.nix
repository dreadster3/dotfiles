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
        type = types.string;
        default = config.home.username;
      };
      email = mkOption { type = types.string; };
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.username;
      userEmail = cfg.email;
    };
  };
}
