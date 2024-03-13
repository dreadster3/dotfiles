{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.vmware;
in {
  options = { modules.nixos.vmware = { enable = mkEnableOption "vmware"; }; };

  config = mkIf cfg.enable {
    virtualisation.vmware.host.enable = true;
    virtualisation.vmware.host.extraConfig = ''
      wsFeatureDarkModeSupported = "TRUE"
      mks.gl.allowUnsupportedDrivers = "TRUE"
      mks.vk.allowUnsupportedDevices = "TRUE"'';
  };
}
