{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.stylix;
in
{
  options = {
    modules.homemanager.stylix = {
      enable = mkEnableOption "stylix";
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = false;
      targets = {
        gtk = {
          enable = true;
          flatpakSupport.enable = true;
          extraCss = ''
            @define-color accent_color #cba6f7;
            @define-color accent_bg_color #cba6f7;
          '';
        };
        feh.enable = true;
        mangohud.enable = true;
        i3.enable = true;
      };
    };

    programs.mangohud.settings.background_alpha = mkForce 0.5;
  };
}
