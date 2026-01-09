{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.rustdesk;
in
{
  options = {
    modules.nixos.rustdesk = {
      enable = mkEnableOption "rustdesk";
      relayHosts = mkOption {
        type = types.listOf types.str;
        default = [ ];
      };
    };
  };

  config = mkIf cfg.enable {

    services.rustdesk-server = {
      enable = true;
      openFirewall = true;
      signal = {
        enable = true;
      };
      relay = {
        enable = true;
      };
    };

    systemd.services.rustdesk-signal.serviceConfig.ExecStart =
      lib.mkForce "${config.services.rustdesk-server.package}/bin/hbbs";
  };
}
