{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.stylix;
in {
  options = {
    modules.homemanager.stylix = { enable = mkEnableOption "stylix"; };
  };

  config = mkIf cfg.enable {
    stylix = {
      autoEnable = false;
      targets = {
        feh.enable = true;
        gtk.enable = true;
        hyprpaper.enable = true;
        mangohud.enable = true;
        i3.enable = true;
      };
    };

    programs.mangohud.settings.background_alpha = mkForce 0.5;
  };
}
