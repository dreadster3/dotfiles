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
      extraConfig = ''
        Host vps.dreadster3.com
        ProxyCommand ${getExe pkgs.cloudflared} access ssh --hostname %h
      '';
    };
  };
}
