{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.mobile;
in
{
  options = {
    modules.nixos.mobile = {
      enable = mkEnableOption "mobile";
    };
  };

  config = mkIf cfg.enable {
    services.usbmuxd.enable = true;

    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse
    ];
  };
}
