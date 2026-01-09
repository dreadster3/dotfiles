{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.dconf;
in
{
  options = {
    modules.nixos.dconf = {
      enable = mkEnableOption "dconf";
    };
  };

  config = mkIf cfg.enable {
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      gsettings-desktop-schemas # GTK settings
    ];

    home-manager.sharedModules = [
      {
        dconf = {
          enable = true;
          settings = {
            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
            };
          };
        };
      }
    ];
  };
}
