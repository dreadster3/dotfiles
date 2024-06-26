{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.ssh;
in {
  options = { modules.nixos.ssh = { enable = mkEnableOption "ssh"; }; };

  config = mkIf cfg.enable {
    services.sshguard.enable = true;
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        X11Forwarding = true;
        PermitRootLogin = "no";
      };
    };
  };
}
