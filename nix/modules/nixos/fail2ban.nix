{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.fail2ban;
in {
  options = {
    modules.nixos.fail2ban = { enable = mkEnableOption "fail2ban"; };
  };

  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      maxretry = 3;
      bantime = "1h";
      bantime-increment = {
        enable = true;
        factor = "24";
        overalljails = true;
      };
      ignoreIP = [ "172.19.0.0/16" ];
    };
  };
}
