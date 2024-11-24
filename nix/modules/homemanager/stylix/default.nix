{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.stylix;
in
{
  imports = [ ./polybar.nix ./waybar ];

  options = {
    modules.homemanager.stylix = { enable = mkEnableOption "stylix"; };
  };

  config = mkIf cfg.enable {
    stylix = {
      autoEnable = false;
      targets = {
        alacritty.enable = false;
        bat.enable = false;
        btop.enable = false;
        dunst.enable = false;
        kitty.enable = false;
        lazygit.enable = false;
        rofi.enable = false;

        bspwm.enable = true;
        feh.enable = true;
        gtk.enable = true;
        hyprland.enable = true;
        firefox = {
          enable = true;
          profileNames = [ "dreadster" ];
        };
        hyprpaper.enable = true;
        mangohud.enable = true;
        polybar.enable = true;

        # Plugin takes care of styling
        tmux.enable = false;
        waybar.enable = false;
        waybar-custom.enable = true;

        zathura.enable = true;
      };
    };

    programs.mangohud.settings.background_alpha = mkForce 0.5;
  };
}
