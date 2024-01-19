{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.hyprland;
in {
  options = { modules.hyprland = { enable = mkEnableOption "hyprland"; }; };

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      enableNvidiaPatches = true;
      xwayland.enable = true;
      systemd.enable = true;
      settings = {
        "$mainMod" = "SUPER";
        monitor = [
          "DP-1,preferred,1080x0,auto"
          "HDMI-A-1,preferred,0x0,auto,transform,1"
          ",preferred,auto,auto"
        ];

        exec-once = [
          "${lib.getExe pkgs.waybar}"
          ''hyprctl setcursor "Catppuccin-Mocha-Blue-Cursors" 24''
        ];

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
        };

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
        };

        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 8;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        animations = {
          enabled = "yes";

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        master = { new_is_master = true; };

        "device:epic-mouse-v1" = { sensitivity = -0.5; };

        env = [ "GUAKE_ENABLE_WAYLAND,1" "WLR_NO_HARDWARE_CURSORS,1" ];

        windowrulev2 = [
          "animation slide,class:^(wofi)$"
          "float,class:^(pavucontrol)$"
          "float,title:^(Guake!)$"
          "move 10% 5%, title:^(Guake!)$"
          "size 80% 50%, title:^(Guake!)$"
          "animation slide, title:^(Guake!)$"
          "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
          "noanim,class:^(xwaylandvideobridge)$"
          "nofocus,class:^(xwaylandvideobridge)$"
          "noinitialfocus,class:^(xwaylandvideobridge)$"
        ];

        bind = [
          "$mainMod, Return, exec, kitty"
          "$mainMod, W, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, thunar"
          "$mainMod, S, togglefloating,"
          "$mainMod, F, fullscreen"
          "$mainMod, D, exec, pkill wofi || wofi --show drun"
          "$mainMod, Space, exec, pkill wofi || wofi --show drun"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, J, togglesplit, # dwindle"
          ", Print, exec, QT_SCALE_FACTOR=0.80 flameshot gui"
          ", Print, exec, grimblast copysave screen"
          "SHIFT, Print, exec, grimblast copysave area"
          "$mainMod, L, exec, ~/.config/hypr/scripts/lock_screen.sh"
          "$mainMod_SHIFT, L, exec, systemctl suspend"
          ", F12, exec, guake-toggle"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };

  };
}
