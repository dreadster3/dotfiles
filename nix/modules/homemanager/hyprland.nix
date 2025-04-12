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
      terminal = mkOption {
        type = types.nullOr types.package;
        default = null;
        description = "Terminal to use.";
      };
      fileManager = mkOption {
        type = types.package;
        default = pkgs.xfce.thunar;
        description = "File manager to use.";
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
      extraConfig = ''
        bind = $mainMod, ESC, submap, clean
        submap = clean
        bind = $mainMod, ESC, submap, reset
        submap = reset
      '';
      settings = {
        "$mainMod" = "SUPER";

        monitor = mapAttrsToList (name: monitor:
          "${name},${monitor.resolution},${monitor.position},${
            toString monitor.zoom
          }${transformToString monitor.transform}") monitors
          ++ [ "Unknown-1,disable" ",preferred,auto,1.0" ];

        exec-once = [
          ''
            ${pkgs.hyprland}/bin/hyprctl setcursor "Catppuccin-Mocha-Blue-Cursors" 24''
        ] ++ cfg.startupPrograms;

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          mouse_refocus = false;
          sensitivity = 0;
        };

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          resize_on_border = true;
          layout = "dwindle";
        };

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"

          # GTK Variables
          "GDK_BACKEND,wayland,x11,*"

          # QT Variables
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        ];

        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 8;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };
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
          pseudotile = true;
          preserve_split = true;
          smart_split = true;
          smart_resizing = false;
        };

        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        windowrulev2 = [
          # Animations
          "animation slide, class:^(wofi)$"
          "animation slide, class:^(rofi)$"

          # Floating
          "float, class:^(pavucontrol)$"

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
          "$mainMod, E, exec, ${getExe cfg.fileManager}"

          # Mode keybinds
          "$mainMod, S, togglefloating,"
          "$mainMod, F, fullscreen"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, T, togglesplit, # dwindle"

          "$mainMod_SHIFT, L, exec, systemctl suspend"

          # Print screen keybinds
          ", Print, exec, ${pkgs.grimblast}/bin/grimblast copysave screen"
          "SHIFT, Print, exec, ${pkgs.grimblast}/bin/grimblast copysave area"

          # Move focus arrow keybinds
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Move focus vim keybinds
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          # Workspace keybinds
          "$mainMod_CTRL, left, workspace, r-1"
          "$mainMod_CTRL, right, workspace, r+1"

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
      };
    };
  };
}
