{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.nixos.virtualisation.vmware.guest;
in {
  options = {
    modules.nixos.virtualisation.vmware.guest = {
      enable = mkEnableOption "virtualisation.vmware.guest";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "vmware" ];
    virtualisation.vmware.guest.enable = true;

    home-manager.sharedModules = [{
      xserver.windowManager.i3.config.startup = [{
        command =
          "${config.virtualisation.vmware.guest.package}/bin/vmware-user-suid-wrapper";
        always = true;
        notification = false;
      }];
    }];
  };
}
