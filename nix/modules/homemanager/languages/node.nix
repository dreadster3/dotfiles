{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.node;
in
{
  options = {
    modules.homemanager.languages.node = {
      enable = mkEnableOption "node toolchain";
      package = mkOption {
        type = types.package;
        default = pkgs.nodejs;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cfg.package
      pnpm
    ];

    home.sessionVariables = {
      PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
      BUN_INSTALL = "${config.home.homeDirectory}/.local/share/bun";
      NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.local/share/npm";
    };

    home.sessionPath = [
      config.home.sessionVariables.PNPM_HOME
      "${config.home.sessionVariables.BUN_INSTALL}/bin"
      "${config.home.sessionVariables.NPM_CONFIG_PREFIX}/bin"
    ];

    programs.bun.enable = true;
  };
}
