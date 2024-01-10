{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.xbindkeys;

  mkBinding = evt: command: ''
    "${command}"
      ${evt}
  '';

  toConf = attrs: "${concatStringsSep "\n" (mapAttrsToList mkBinding attrs)}";

  configFile = toConf cfg.settings;

in {
  options = {
    modules.xbindkeys = {
      enable = mkEnableOption "xbindkeys";
      withGui = mkOption {
        type = types.bool;
        default = false;
        description = "Enable xbindkeys GUI";
      };
      settings = mkOption {
        type = types.attrsOf types.string;
        default = { };
        description = "xbindkeys settings";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [ xbindkeys ] ++ (if cfg.withGui then [ xbindkeys_config ] else [ ]);

    home.file.".xbindkeysrc".text = configFile;
  };
}