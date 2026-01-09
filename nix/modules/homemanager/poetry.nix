{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.poetry;
in
{
  options = {
    modules.homemanager.poetry = {
      enable = mkEnableOption "poetry";
      package = mkOption {
        type = types.package;
        default = pkgs.poetry;
        description = "The Python dependency manager";
      };
    };
  };
  config = mkIf cfg.enable {
    programs.poetry = {
      enable = true;
      settings = {
        virtualenvs.create = true;
        virtualenvs.in-project = true;
        virtualenvs.options.system-site-packages = true;
        virtualenvs.prefer-active-python = true;
      };
    };
  };
}
