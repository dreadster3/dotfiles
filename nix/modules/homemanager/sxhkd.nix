{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.sxhkd;
in {
  options = {
    modules.homemanager.sxhkd = {
      enable = mkEnableOption "sxhkd";
      terminal = mkOption {
        type = types.package;
        default = pkgs.kitty;
        description = "The terminal to use";
      };
    };
  };

  config = mkIf cfg.enable {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = lib.getExe cfg.terminal;
        "super + @space" = "${lib.getExe pkgs.rofi} -show drun";
        "super + ctrl + q" =
          "${lib.getExe pkgs.betterlockscreen} -l blur --display 1";
        "Print" = "${lib.getExe pkgs.flameshot} gui";
        "super + Escape" = "pkill -USR1 -x sxhkd";
        "super + d" = "${lib.getExe pkgs.rofi} -show run";
        "super + q" = "${lib.getExe pkgs.rofi} -show p -modi 'p:${
            lib.getExe pkgs.rofi-power-menu
          }'";
        "super + alt + {q,r}" = "bspc {quit, wm -r}";
        "super + {_, shift + }w" = "bspc node -{c,k}";
        "super + m" = "bspc desktop -l next";
        "super + {t,shift + t,s,f}" =
          "bspc node -t {tiled,pseudo_tiled,floating,~fullscreen}";
        "super + {_, shift + }{h,j,k,l}" =
          "bspc node -{f,s} {west,south,north,east}";
        "super + {_,shift + }c" = "bspc node -{next,prev}.local.!hidden.window";
        "super + ctrl + {Left,Right}" = "bspc desktop -f {prev,next}.local";
        "super + Tab" = "bspc desktop -f last";
        "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '{1-9,10}'";
        "super + alt + {h,j,k,l}" =
          "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
        "super + alt + shift + {h,j,k,l}" =
          "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      };
    };
  };
}
