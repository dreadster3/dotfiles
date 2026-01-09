{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.catppuccin;
in
{
  options = {
    modules.nixos.catppuccin = {
      enable = mkEnableOption "catppuccin";
    };
  };

  config =
    let
      catppuccinConfig = {
        enable = true;
        flavor = "mocha";
        accent = "mauve";
      };

    in
    mkIf cfg.enable {
      catppuccin = catppuccinConfig // {
        gitea.enable = false;
        forgejo.enable = false;
        fcitx5.enable = false;
      };

      environment.variables.XCURSOR_SIZE = 24;

      home-manager.sharedModules = [
        {
          modules.homemanager.catppuccin = mkDefault catppuccinConfig;
          home.pointerCursor.size = strings.toInt config.environment.variables.XCURSOR_SIZE;
        }
      ];
    };
}
