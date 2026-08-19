{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.thunar;
in
{
  options = {
    modules.nixos.thunar = {
      enable = mkEnableOption "thunar";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ xfce4-exo ];

    programs.xfconf.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    services = {
      gvfs.enable = true;
      tumbler.enable = true;
    };
  };
}
