{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.go;
in
{
  options = {
    modules.homemanager.languages.go = {
      enable = mkEnableOption "go toolchain";
      package = mkOption {
        type = types.package;
        default = pkgs.go;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cfg.package
      gopls
    ];

    home.sessionPath = [ "${config.home.homeDirectory}/go/bin" ];
  };
}
