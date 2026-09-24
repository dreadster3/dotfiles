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
      languageServer = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "go language server";
            package = mkOption {
              type = types.package;
              default = pkgs.gopls;
            };
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ] ++ optional cfg.languageServer.enable cfg.languageServer.package;

    home.sessionPath = [ "${config.home.homeDirectory}/go/bin" ];
  };
}
