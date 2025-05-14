{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.homemanager.hyprland;

  transformToString = transform:
    if transform == null then "" else ",transform,${toString transform}";

  monitors = config.modules.homemanager.settings.monitors.wayland
    // cfg.monitors;

  terminal = either cfg.terminal config.modules.homemanager.settings.terminal;
in {
  options = {
    modules.homemanager.hyprland = {
      enable = mkEnableOption "hyprland";
      package = mkOption {
        type = types.package;
        default = pkgs.hyprland;
      };
      portalPackage = mkOption {
        type = types.package;
        default = pkgs.xdg-desktop-portal-hyprland;
      };
      terminal = mkOption {
        type = types.nullOr types.package;
        default = null;
        description = "Terminal to use.";
      };
      monitors = mkOption {
        type = types.monitorMap;
        default = { };
        description = "List of monitors to configure.";
      };
      startupPrograms = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "List of programs to start on login.";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = monitors != { };
      message = "No monitors configured.";
    }];

    home.packages = with pkgs; [ wl-clipboard grimblast ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
        variables = [ "--all" ];
      };

      plugins = with pkgs.hyprlandPlugins; [ hyprspace ];

      settings = {
        "$mainMod" = "SUPER";

        monitor = mapAttrsToList (name: monitor:
          "${name},${monitor.resolution},${monitor.position},${
            toString monitor.zoom
          }${transformToString monitor.transform}") monitors
          ++ [ "Unknown-1,disable" ",preferred,auto,1.0" ];

        exec-once = cfg.startupPrograms;

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          mouse_refocus = false;
          sensitivity = 0;
        };

        general = {
          gaps_in = 4;
          gaps_out = 5;
          gaps_workspaces = 50;

          border_size = 2;
          resize_on_border = true;
          layout = "dwindle";
          no_focus_fallback = true;
          allow_tearing = true;
        };

        env = [
          # GTK Variables
          "GDK_BACKEND,wayland,x11,*"

          # QT Variables
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        ];

        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 20;

          blur = {
            enabled = true;
            xray = true;
            new_optimizations = true; # Needed by xray
            size = 14;
            passes = 4;
            brightness = 1;
            noise = 1.0e-2;
            contrast = 1;
            popups = true;
            popups_ignorealpha = 0.6;
          };

          shadow = {
            enabled = true;
            ignore_window = true;
            offset = "0 2";
            range = 20;
            render_power = 4;
          };
        };

        animations = {
          enabled = true;

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = [
            # "myBezier, 0.05, 0.9, 0.1, 1.05"
            "linear, 0, 0, 1, 1"
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92 "
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "menu_decel, 0.1, 1, 0, 1"
            "menu_accel, 0.38, 0.04, 1, 0.07"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
            "softAcDecel, 0.26, 0.26, 0.15, 1"
            "md2, 0.4, 0, 0.2, 1"
          ];

          animation = [
            # "windows, 1, 7, myBezier"
            # "windowsOut, 1, 7, default, popin 80%"
            # "border, 1, 10, default"
            # "borderangle, 1, 8, default"
            # "fade, 1, 7, default"
            # "workspaces, 1, 6, default"
            "windows, 1, 3, md3_decel, popin 60%"
            "windowsIn, 1, 3, md3_decel, popin 60%"
            "windowsOut, 1, 3, md3_accel, popin 60%"
            "border, 1, 10, default"
            "fade, 1, 3, md3_decel"
            "layersIn, 1, 3, menu_decel, slide"
            "layersOut, 1, 1.6, menu_accel"
            "fadeLayersIn, 1, 2, menu_decel"
            "fadeLayersOut, 1, 0.5, menu_accel"
            "workspaces, 1, 7, menu_decel, slide"
            "specialWorkspace, 1, 3, md3_decel, slidevert"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
          smart_split = true;
          smart_resizing = false;
        };

        windowrulev2 = [
          # Animations
          "animation slide, class:^(wofi)$"
          "animation slide, class:^(rofi)$"

          # pavucontrol
          "float, class:^(org.pulseaudio.pavucontrol)$"
          "size 45%, class:^(org.pulseaudio.pavucontrol)$"
          "center%, class:^(org.pulseaudio.pavucontrol)$"

          # Tile
          "tile,initialTitle:^(ErgoDox EZ Configurator)$"

          # xwaylandvideobridge
          "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
          "noanim,class:^(xwaylandvideobridge)$"
          "nofocus,class:^(xwaylandvideobridge)$"
          "noinitialfocus,class:^(xwaylandvideobridge)$"

          # steam
          "stayfocused, title:^()$,class:^(steam)$"
          "minsize 1 1, title:^()$,class:^(steam)$"
          "immediate, class:^(steam_app)"
          "immediate, title:.*.exe"

          # Picture-in-Picture
          "move 73% 72%, title:^([Pp]icture[-s]?[Ii]n[-s]?[Pp]icture)(.*)$ "
          "size 25%, title:^([Pp]icture[-s]?[Ii]n[-s]?[Pp]icture)(.*)$"
          "float, title:^([Pp]icture[-s]?[Ii]n[-s]?[Pp]icture)(.*)$"
          "pin, title:^([Pp]icture[-s]?[Ii]n[-s]?[Pp]icture)(.*)$"

          # Popout
          "move 73% 72%, initialTitle:^(.*)([Pp]opout)(.*)$"
          "size 25%, initialTitle:^(.*)([Pp]opout)(.*)$"
          "float, initialTitle:^(.*)([Pp]opout)(.*)$"
          "pin, initialTitle:^(.*)([Pp]opout)(.*)$"
        ];

        workspace = foldlAttrs (acc: name: monitor:
          acc ++ (map (workspace: "${toString workspace},monitor:${name}")
            monitor.workspaces)) [ ] monitors;

        bind = [
          "$mainMod, Return, exec, ${getExe terminal}"

          "$mainMod, W, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, ${getExe pkgs.alacritty} -e yazi"
          "$mainMod+Shift, E, exec, ${getExe pkgs.xfce.thunar}"

          # Mode keybinds
          "$mainMod, S, togglefloating,"
          "$mainMod, F, fullscreen"
          "$mainMod, T, togglesplit, # dwindle"
          "$mainMod, P, pin"

          "Alt, Tab, cyclenext"
          "Alt, Tab, bringactivetotop"

          "$mainMod, Tab, overview:toggle,"

          # Minimize
          "$mainMod, C, togglespecialworkspace, minimize"
          "$mainMod, C, movetoworkspace, +0"
          "$mainMod, C, togglespecialworkspace, minimize"
          "$mainMod, C, movetoworkspace, special:minimize"
          "$mainMod, C, togglespecialworkspace, minimize"

          # Print screen keybinds
          ", Print, exec, ${pkgs.grimblast}/bin/grimblast copysave output"
          "Shift, Print, exec, ${pkgs.grimblast}/bin/grimblast copysave area"
          "Ctrl+Shift, Print, exec, ${pkgs.grimblast}/bin/grimblast copysave screen"

          # Move arrow keybinds
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod+Shift, left, movewindow, l"
          "$mainMod+Shift, right, movewindow, r"
          "$mainMod+Shift, up, movewindow, u"
          "$mainMod+Shift, down, movewindow, d"

          # Move vim keybinds
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod+Shift, h, movewindow, l"
          "$mainMod+Shift, l, movewindow, r"
          "$mainMod+Shift, k, movewindow, u"
          "$mainMod+Shift, j, movewindow, d"

          # Workspace keybinds
          "$mainMod+Ctrl, left, workspace, r-1"
          "$mainMod+Ctrl, right, workspace, r+1"

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

          "$mainMod+Shift, 1, movetoworkspace, 1"
          "$mainMod+Shift, 2, movetoworkspace, 2"
          "$mainMod+Shift, 3, movetoworkspace, 3"
          "$mainMod+Shift, 4, movetoworkspace, 4"
          "$mainMod+Shift, 5, movetoworkspace, 5"
          "$mainMod+Shift, 6, movetoworkspace, 6"
          "$mainMod+Shift, 7, movetoworkspace, 7"
          "$mainMod+Shift, 8, movetoworkspace, 8"
          "$mainMod+Shift, 9, movetoworkspace, 9"
          "$mainMod+Shift, 0, movetoworkspace, 10"

          "$mainMod, mouse_down, workspace, m+1"
          "$mainMod, mouse_up, workspace, m-1"

        ];

        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];

        bindl = [
          ", XF86AudioPlay, exec, playerctl --player spotify play-pause"
          ", XF86AudioPause, exec, playerctl --player spotify play-pause"
          ", XF86AudioPrev, exec, playerctl --player spotify previous"
          ", XF86AudioNext, exec, playerctl --player spotify next"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        misc = {
          enable_swallow = false;
          force_default_wallpaper = 0;
          disable_hyprland_logo = false;
          new_window_takes_over_fullscreen = 2;
          allow_session_lock_restore = true;
          initial_workspace_tracking = 0; # Disabled
          vfr = true;
          vrr = 1; # Enable vsync
        };
      };

      extraConfig = ''
        bind = $mainMod, Escape, submap, clean
        submap = clean
        bind = $mainMod, Escape, submap, reset
        submap = reset

        source = $HOME/.config/hypr/monitors.conf
        source = $HOME/.config/hypr/startup.conf
      '';
    };
  };
}
