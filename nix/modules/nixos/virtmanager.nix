{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.nixos.virtmanager;
in {
  options = {
    modules.nixos.virtmanager = { enable = mkEnableOption "virtmanager"; };
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
      qemu.ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
    programs.virt-manager.enable = true;

    users.extraUsers.dreadster.extraGroups = [ "libvirtd" "kvm" "input" ];

    boot.extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1
    '';

    environment.etc = {
      "ovmf/edk2-x86_64-secure-code.fd" = {
        source = config.virtualisation.libvirtd.qemu.package
          + "/share/qemu/edk2-x86_64-secure-code.fd";
      };

      "ovmf/edk2-i386-vars.fd" = {
        source = config.virtualisation.libvirtd.qemu.package
          + "/share/qemu/edk2-i386-vars.fd";
      };
    };

    home-manager.sharedModules = [{
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
      };
    }];
  };
}
