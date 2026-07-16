{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.ssh;
in
{
  options = {
    modules.homemanager.ssh = {
      enable = mkEnableOption "ssh";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ cloudflared ];

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          ForwardAgent = false;
          AddKeysToAgent = "no";
          Compression = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "no";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
        };
      };
    };
  };
}
