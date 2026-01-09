{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.xbindkeys;

  mkBinding = evt: command: ''
    "${command}"
      ${evt}
  '';

  toConf = attrs: "${concatStringsSep "\n" (mapAttrsToList mkBinding attrs)}";

  configFile = toConf cfg.settings;

in
{
  options = {
    modules.homemanager.xbindkeys = {
      enable = mkEnableOption "xbindkeys";
      package = mkOption {
        type = types.package;
        default = pkgs.xbindkeys;
        description = "xbindkeys package";
      };
      withGui = mkOption {
        type = types.bool;
        default = false;
        description = "Enable xbindkeys GUI";
      };
      settings = mkOption {
        type = types.attrsOf types.str;
        default = { };
        description = "xbindkeys settings";
      };
    };
  };

  config = mkIf cfg.enable {
    xsession.windowManager.bspwm.startupPrograms = [ "${cfg.package}/bin/xbindkeys" ];

    home.packages = [ cfg.package ] ++ (optional cfg.withGui pkgs.xbindkeys_config);

    home.file.".xbindkeysrc".text = configFile;
  };
}
