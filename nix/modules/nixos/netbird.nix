{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.netbird;
in
{
  options = {
    modules.nixos.netbird = {
      enable = mkEnableOption "netbird";
      package = mkPackageOption pkgs "netbird" { };
      ui = mkOption {
        type = types.submodule {
          options = {
            enable = mkOption {
              type = types.bool;
              default = true;
              description = "Whether to enable the netbird-ui.";
            };
            package = mkPackageOption pkgs "netbird-ui" { };
          };
        };
        description = "Options for the netbird-ui.";
        default = { };
      };
    };
  };

  config = mkIf cfg.enable {
    services.netbird = {
      enable = true;
      inherit (cfg) package;
      ui = {
        inherit (cfg.ui) enable package;
      };
    };
  };
}
