{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.ssh;
in
{
  options = {
    modules.nixos.ssh = {
      enable = mkEnableOption "ssh";
      passwordAuthentication = mkOption {
        type = types.bool;
        default = false;
      };
      permitRootLogin = mkOption {
        type = types.str;
        default = "no";
      };
    };
  };

  config = mkIf cfg.enable {
    services.sshguard.enable = true;

    programs.ssh.startAgent = true;

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = cfg.passwordAuthentication;
        X11Forwarding = config.services.xserver.enable;
        PermitRootLogin = cfg.permitRootLogin;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
