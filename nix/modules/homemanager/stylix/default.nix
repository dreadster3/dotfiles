{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.stylix;
in {
  imports = [ ./polybar.nix ];

  options = {
    modules.homemanager.stylix = { enable = mkEnableOption "stylix"; };
  };

  config = mkIf cfg.enable {
    stylix = {
      autoEnable = false;
      targets = {
        alacritty.enable = true;
        bat.enable = true;
        btop.enable = true;
        bspwm.enable = true;
        dunst.enable = true;
        feh.enable = true;
        firefox = {
          enable = true;
          profileNames = [ "dreadster" ];
        };
        gtk.enable = true;
        hyprland.enable = true;
        hyprpaper.enable = true;
        kitty.enable = true;
        lazygit.enable = true;
        mangohud.enable = true;
        polybar.enable = true;
        rofi.enable = true;

        # Plugin takes care of styling
        tmux.enable = false;

        waybar.enable = true;
        zathura.enable = true;
      };
    };
  };
}
