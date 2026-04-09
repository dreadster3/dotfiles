{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.aio;
in
{
  options = {
    modules.nixos.aio = {
      enable = mkEnableOption "aio";
      coolercontrol = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "aio.coolercontrol";
            package = mkPackageOption pkgs.coolercontrol "coolercontrold" { };
            ui = mkOption {
              type = types.submodule {
                options = {
                  enable = mkEnableOption "aio.coolercontrol.ui";
                  package = mkPackageOption pkgs.coolercontrol "coolercontrol-gui" { };
                };
              };
              default = {
                enable = true;
              };
            };
          };
        };
        default = {
          enable = true;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
        lm_sensors
        liquidctl
      ]
      ++ optionals (cfg.coolercontrol.enable && cfg.coolercontrol.ui.enable) [
        cfg.coolercontrol.ui.package
      ];

    systemd = mkIf cfg.coolercontrol.enable {
      packages = [ cfg.coolercontrol.package ];
      services = {
        coolercontrold.wantedBy = [ "multi-user.target" ];
      };
    };

    # INFO: Does not allow setting package
    # programs.coolercontrol.enable = true;
  };
}
