{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.virtualisation.vmware.host;
in {
  options = {
    modules.nixos.virtualisation.vmware.host = {
      enable = mkEnableOption "virtualisation.vmware.host";
      package = mkOption {
        type = types.package;
        default = pkgs.vmware-workstation;
        description = "The VMware Tools package to install.";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.vmware.host = {
      enable = true;
      package = cfg.package.override { enableMacOSGuests = true; };
      extraConfig = ''
        wsFeatureDarkModeSupported = "TRUE"
        mks.gl.allowUnsupportedDrivers = "TRUE"
        mks.vk.allowUnsupportedDevices = "TRUE"
      '';
    };
  };
}
