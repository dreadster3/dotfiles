{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.hyprland;

  monitors = config.modules.homemanager.settings.monitors.wayland // cfg.monitors;

  mkInline = lib.generators.mkLuaInline;

  terminal = either cfg.terminal config.modules.homemanager.settings.terminal;
  terminalBin = getExe terminal;
in
{
  options = {
    modules.homemanager.hyprland = {
      enable = mkEnableOption "hyprland";
      package = mkOption {
        type = types.nullOr types.package;
        default = null;
      };
      portalPackage = mkOption {
        type = types.nullOr types.package;
        default = null;
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
    assertions = [
      {
        assertion = monitors != { };
        message = "No monitors configured.";
      }
    ];

    home.packages = with pkgs; [
      hyprsysteminfo

      wl-clipboard
      grimblast
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      inherit (cfg) package portalPackage;
      configType = "lua";

      xwayland.enable = true;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
        variables = [ "--all" ];
      };

      extraConfig = ''
        -- Import nwg-displays configuration
        require("monitors")
      '';

      settings = {
        # ── Environment variables ───────────────────────────────
        env = [
          {
            _args = [
              "GDK_BACKEND"
              "wayland,x11,*"
            ];
          }
          {
            _args = [
              "QT_QPA_PLATFORM"
              "wayland;xcb"
            ];
          }
          {
            _args = [
              "QT_WAYLAND_DISABLE_WINDOWDECORATION"
              "1"
            ];
          }
          {
            _args = [
              "QT_AUTO_SCREEN_SCALE_FACTOR"
              "1"
            ];
          }
        ];

        # ── Beziers ──────────────────────────────────────────────
        curve = [
          {
            _args = [
              "linear"
              (mkInline ''{ type = "bezier", points = { {0, 0},      {1, 1}       } }'')
            ];
          }
          {
            _args = [
              "md3_standard"
              (mkInline ''{ type = "bezier", points = { {0.2, 0},    {0, 1}       } }'')
            ];
          }
          {
            _args = [
              "md3_decel"
              (mkInline ''{ type = "bezier", points = { {0.05, 0.7}, {0.1, 1}     } }'')
            ];
          }
          {
            _args = [
              "md3_accel"
              (mkInline ''{ type = "bezier", points = { {0.3, 0},    {0.8, 0.15}  } }'')
            ];
          }
          {
            _args = [
              "overshot"
              (mkInline ''{ type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1}   } }'')
            ];
          }
          {
            _args = [
              "crazyshot"
              (mkInline ''{ type = "bezier", points = { {0.1, 1.5},  {0.76, 0.92} } }'')
            ];
          }
          {
            _args = [
              "hyprnostretch"
              (mkInline ''{ type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0}   } }'')
            ];
          }
          {
            _args = [
              "menu_decel"
              (mkInline ''{ type = "bezier", points = { {0.1, 1},    {0, 1}       } }'')
            ];
          }
          {
            _args = [
              "menu_accel"
              (mkInline ''{ type = "bezier", points = { {0.38, 0.04},{1, 0.07}    } }'')
            ];
          }
          {
            _args = [
              "easeInOutCirc"
              (mkInline ''{ type = "bezier", points = { {0.85, 0},   {0.15, 1}    } }'')
            ];
          }
          {
            _args = [
              "easeOutCirc"
              (mkInline ''{ type = "bezier", points = { {0, 0.55},   {0.45, 1}    } }'')
            ];
          }
          {
            _args = [
              "easeOutExpo"
              (mkInline ''{ type = "bezier", points = { {0.16, 1},   {0.3, 1}     } }'')
            ];
          }
          {
            _args = [
              "softAcDecel"
              (mkInline ''{ type = "bezier", points = { {0.26, 0.26},{0.15, 1}    } }'')
            ];
          }
          {
            _args = [
              "md2"
              (mkInline ''{ type = "bezier", points = { {0.4, 0},    {0.2, 1}     } }'')
            ];
          }
        ];

        # ── Animations ───────────────────────────────────────────
        animation = [
          {
            leaf = "windows";
            enabled = true;
            speed = 3;
            bezier = "md3_decel";
            style = "popin 60%";
          }
          {
            leaf = "windowsIn";
            enabled = true;
            speed = 3;
            bezier = "md3_decel";
            style = "popin 60%";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 3;
            bezier = "md3_accel";
            style = "popin 60%";
          }
          {
            leaf = "border";
            enabled = true;
            speed = 10;
            bezier = "default";
          }
          {
            leaf = "fade";
            enabled = true;
            speed = 3;
            bezier = "md3_decel";
          }
          {
            leaf = "layersIn";
            enabled = true;
            speed = 3;
            bezier = "menu_decel";
            style = "slide";
          }
          {
            leaf = "layersOut";
            enabled = true;
            speed = 1.6;
            bezier = "menu_accel";
          }
          {
            leaf = "fadeLayersIn";
            enabled = true;
            speed = 2;
            bezier = "menu_decel";
          }
          {
            leaf = "fadeLayersOut";
            enabled = true;
            speed = 0.5;
            bezier = "menu_accel";
          }
          {
            leaf = "workspaces";
            enabled = true;
            speed = 7;
            bezier = "menu_decel";
            style = "slide";
          }
          {
            leaf = "specialWorkspace";
            enabled = true;
            speed = 3;
            bezier = "md3_decel";
            style = "slidevert";
          }
        ];

        # ── Main config ──────────────────────────────────────────
        config = {
          general = {
            allow_tearing = true;
            border_size = 2;
            gaps_in = 4;
            gaps_out = 5;
            gaps_workspaces = 50;
            layout = "dwindle";
            no_focus_fallback = true;
            resize_on_border = false;
          };

          input = {
            follow_mouse = 1;
            kb_layout = "us";
            mouse_refocus = false;
            sensitivity = 0;
          };

          misc = {
            allow_session_lock_restore = true;
            disable_hyprland_logo = false;
            enable_anr_dialog = true;
            enable_swallow = false;
            force_default_wallpaper = 0;
            initial_workspace_tracking = 0;
            on_focus_under_fullscreen = 2;
          };

          decoration = {
            blur = {
              brightness = 1;
              contrast = 1;
              enabled = true;
              new_optimizations = true;
              noise = 0.01;
              passes = 4;
              popups = true;
              popups_ignorealpha = 0.6;
              size = 14;
              xray = true;
            };
            rounding = 20;
            shadow = {
              enabled = true;
              offset = [
                0
                2
              ];
              range = 20;
              render_power = 4;
            };
          };

          dwindle = {
            preserve_split = true;
            smart_resizing = false;
            smart_split = true;
          };

          animations = {
            enabled = true;
          };

          xwayland = {
            force_zero_scaling = true;
          };
        };

        # ── Monitor ──────────────────────────────────────────────
        monitor = {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1.0;
        };

        # ── Window rules ─────────────────────────────────────────
        window_rule = [
          {
            name = "Wofi Slide In Animation";
            match = {
              class = "wofi";
            };
            animation = "slide";
          }
          {
            name = "Rofi Slide In Animation";
            match = {
              class = "rofi";
            };
            animation = "slide";
          }
          {
            name = "pavucontrol";
            match = {
              class = "^(org.pulseaudio.pavucontrol)$";
            };
            float = true;
            center = true;
            size = [
              "monitor_w * 0.4"
              "monitor_h * 0.4"
            ];
          }
          {
            name = "XWayland Video Bridge";
            match = {
              class = "^(xwaylandvideobridge)$";
            };
            opacity = "0.0";
            no_anim = true;
            no_blur = true;
            no_focus = true;
            no_initial_focus = true;
            max_size = [
              1
              1
            ];
          }
          {
            name = "Steam";
            match = {
              class = "^(steam)$";
              title = "^()$";
            };
            stay_focused = true;
          }
          {
            name = "Steam Apps";
            match = {
              class = "^(steam_app)$";
            };
            immediate = true;
          }
          {
            name = "Windows Executables";
            match = {
              title = ".*.exe";
            };
            immediate = true;
          }
          {
            name = "Picture-in-Picture";
            match = {
              title = "^([Pp]icture[-s]?[Ii]n[-s]?[Pp]icture)(.*)$";
            };
            float = true;
            pin = true;
            move = [
              "monitor_w * 0.73"
              "monitor_h * 0.72"
            ];
            size = [
              "monitor_w * 0.25"
              "monitor_h * 0.25"
            ];
          }
          {
            name = "Popout";
            match = {
              initial_title = "^([Pp]opout)(.*)$";
            };
            float = true;
            pin = true;
            move = [
              "monitor_w * 0.73"
              "monitor_h * 0.72"
            ];
            size = [
              "monitor_w * 0.25"
              "monitor_h * 0.25"
            ];
          }
          {
            name = "Tile ErgoDox";
            match = {
              initial_title = "^(ErgoDox EZ Configurator)$";
            };
            tile = true;
          }
          {
            name = "Tile Excalidraw";
            match = {
              initial_title = "^(Excalidraw)$";
            };
            tile = true;
          }
          {
            name = "Float HoyoPlay";
            match = {
              initial_title = "^(HoYoPlay)$";
            };
            float = true;
            move = [
              "monitor_w * 0.50"
              "monitor_h * 0.50"
            ];
            size = [
              "monitor_w * 0.25"
              "monitor_h * 0.25"
            ];
          }
        ];

        # ── Workspace rules ──────────────────────────────────────
        workspace_rule = [
          {
            workspace = "1";
            monitor = "DP-1";
          }
          {
            workspace = "2";
            monitor = "DP-1";
          }
          {
            workspace = "3";
            monitor = "DP-1";
          }
          {
            workspace = "4";
            monitor = "DP-1";
          }
          {
            workspace = "5";
            monitor = "DP-1";
          }
          {
            workspace = "6";
            monitor = "HDMI-A-1";
          }
          {
            workspace = "7";
            monitor = "HDMI-A-1";
          }
          {
            workspace = "8";
            monitor = "HDMI-A-1";
          }
          {
            workspace = "9";
            monitor = "HDMI-A-1";
          }
          {
            workspace = "10";
            monitor = "HDMI-A-1";
          }
        ];

        # ── Keybinds: App launches ────────────────────────────────
        bind = [
          {
            _args = [
              "SUPER + Return"
              (mkInline ''hl.dsp.exec_cmd("${terminalBin}")'')
            ];
          }
          {
            _args = [
              "SUPER + W"
              (mkInline "hl.dsp.window.close()")
            ];
          }
          {
            _args = [
              "SUPER + M"
              (mkInline "hl.dsp.exit()")
            ];
          }
          {
            _args = [
              "SUPER + E"
              (mkInline ''hl.dsp.exec_cmd("${terminalBin} -e yazi")'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + E"
              (mkInline ''hl.dsp.exec_cmd("${getExe pkgs.thunar}")'')
            ];
          }
          {
            _args = [
              "SUPER + CTRL + Q"
              (mkInline ''hl.dsp.exec_cmd("loginctl lock-session")'')
            ];
          }

          # Window management
          {
            _args = [
              "SUPER + S"
              (mkInline "hl.dsp.window.float()")
            ];
          }
          {
            _args = [
              "SUPER + F"
              (mkInline "hl.dsp.window.fullscreen()")
            ];
          }
          {
            _args = [
              "SUPER + T"
              (mkInline ''hl.dsp.layout("togglesplit")'')
            ];
          }
          {
            _args = [
              "SUPER + P"
              (mkInline "hl.dsp.window.pin()")
            ];
          }
          {
            _args = [
              "SUPER + C"
              (mkInline ''hl.dsp.workspace.toggle_special("minimize")'')
            ];
          }

          # Screenshots
          {
            _args = [
              "Print"
              (mkInline ''hl.dsp.exec_cmd("${getExe pkgs.grimblast} copysave output")'')
            ];
          }
          {
            _args = [
              "SHIFT + Print"
              (mkInline ''hl.dsp.exec_cmd("${getExe pkgs.grimblast} copysave area")'')
            ];
          }
          {
            _args = [
              "CTRL + SHIFT + Print"
              (mkInline ''hl.dsp.exec_cmd("${getExe pkgs.grimblast} copysave screen")'')
            ];
          }

          # Focus movement
          {
            _args = [
              "SUPER + Left"
              (mkInline ''hl.dsp.focus({ direction = "l" })'')
            ];
          }
          {
            _args = [
              "SUPER + Right"
              (mkInline ''hl.dsp.focus({ direction = "r" })'')
            ];
          }
          {
            _args = [
              "SUPER + Up"
              (mkInline ''hl.dsp.focus({ direction = "u" })'')
            ];
          }
          {
            _args = [
              "SUPER + Down"
              (mkInline ''hl.dsp.focus({ direction = "d" })'')
            ];
          }
          {
            _args = [
              "SUPER + H"
              (mkInline ''hl.dsp.focus({ direction = "l" })'')
            ];
          }
          {
            _args = [
              "SUPER + L"
              (mkInline ''hl.dsp.focus({ direction = "r" })'')
            ];
          }
          {
            _args = [
              "SUPER + K"
              (mkInline ''hl.dsp.focus({ direction = "u" })'')
            ];
          }
          {
            _args = [
              "SUPER + J"
              (mkInline ''hl.dsp.focus({ direction = "d" })'')
            ];
          }

          # Window movement
          {
            _args = [
              "SUPER + SHIFT + Left"
              (mkInline ''hl.dsp.window.move({ direction = "l" })'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + Right"
              (mkInline ''hl.dsp.window.move({ direction = "r" })'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + Up"
              (mkInline ''hl.dsp.window.move({ direction = "u" })'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + Down"
              (mkInline ''hl.dsp.window.move({ direction = "d" })'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + H"
              (mkInline ''hl.dsp.window.move({ direction = "l" })'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + L"
              (mkInline ''hl.dsp.window.move({ direction = "r" })'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + K"
              (mkInline ''hl.dsp.window.move({ direction = "u" })'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + J"
              (mkInline ''hl.dsp.window.move({ direction = "d" })'')
            ];
          }

          # Workspace navigation
          {
            _args = [
              "SUPER + CTRL + Left"
              (mkInline ''hl.dsp.focus({ workspace = "r-1" })'')
            ];
          }
          {
            _args = [
              "SUPER + CTRL + Right"
              (mkInline ''hl.dsp.focus({ workspace = "r+1" })'')
            ];
          }
          {
            _args = [
              "SUPER + 1"
              (mkInline "hl.dsp.focus({ workspace = 1 })")
            ];
          }
          {
            _args = [
              "SUPER + 2"
              (mkInline "hl.dsp.focus({ workspace = 2 })")
            ];
          }
          {
            _args = [
              "SUPER + 3"
              (mkInline "hl.dsp.focus({ workspace = 3 })")
            ];
          }
          {
            _args = [
              "SUPER + 4"
              (mkInline "hl.dsp.focus({ workspace = 4 })")
            ];
          }
          {
            _args = [
              "SUPER + 5"
              (mkInline "hl.dsp.focus({ workspace = 5 })")
            ];
          }
          {
            _args = [
              "SUPER + 6"
              (mkInline "hl.dsp.focus({ workspace = 6 })")
            ];
          }
          {
            _args = [
              "SUPER + 7"
              (mkInline "hl.dsp.focus({ workspace = 7 })")
            ];
          }
          {
            _args = [
              "SUPER + 8"
              (mkInline "hl.dsp.focus({ workspace = 8 })")
            ];
          }
          {
            _args = [
              "SUPER + 9"
              (mkInline "hl.dsp.focus({ workspace = 9 })")
            ];
          }
          {
            _args = [
              "SUPER + 0"
              (mkInline "hl.dsp.focus({ workspace = 10 })")
            ];
          }

          # Move window to workspace
          {
            _args = [
              "SUPER + SHIFT + 1"
              (mkInline "hl.dsp.window.move({ workspace = 1 })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + 2"
              (mkInline "hl.dsp.window.move({ workspace = 2 })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + 3"
              (mkInline "hl.dsp.window.move({ workspace = 3 })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + 4"
              (mkInline "hl.dsp.window.move({ workspace = 4 })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + 5"
              (mkInline "hl.dsp.window.move({ workspace = 5 })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + 6"
              (mkInline "hl.dsp.window.move({ workspace = 6 })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + 7"
              (mkInline "hl.dsp.window.move({ workspace = 7 })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + 8"
              (mkInline "hl.dsp.window.move({ workspace = 8 })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + 9"
              (mkInline "hl.dsp.window.move({ workspace = 9 })")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + 0"
              (mkInline "hl.dsp.window.move({ workspace = 10 })")
            ];
          }

          # Mouse wheel workspace switching
          {
            _args = [
              "SUPER + mouse_down"
              (mkInline ''hl.dsp.focus({ workspace = "m+1" })'')
            ];
          }
          {
            _args = [
              "SUPER + mouse_up"
              (mkInline ''hl.dsp.focus({ workspace = "m-1" })'')
            ];
          }

          # Volume (locked + repeating)
          {
            _args = [
              "XF86AudioRaiseVolume"
              (mkInline ''hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")'')
              {
                locked = true;
                repeating = true;
              }
            ];
          }
          {
            _args = [
              "XF86AudioLowerVolume"
              (mkInline ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'')
              {
                locked = true;
                repeating = true;
              }
            ];
          }

          # Media keys (locked)
          {
            _args = [
              "XF86AudioPlay"
              (mkInline ''hl.dsp.exec_cmd("playerctl --player spotify play-pause")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioPause"
              (mkInline ''hl.dsp.exec_cmd("playerctl --player spotify play-pause")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioPrev"
              (mkInline ''hl.dsp.exec_cmd("playerctl --player spotify previous")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioNext"
              (mkInline ''hl.dsp.exec_cmd("playerctl --player spotify next")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioMute"
              (mkInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioMicMute"
              (mkInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")'')
              { locked = true; }
            ];
          }

          # Mouse binds
          {
            _args = [
              "SUPER + mouse:272"
              (mkInline "hl.dsp.window.drag()")
              { mouse = true; }
            ];
          }
          {
            _args = [
              "SUPER + mouse:273"
              (mkInline "hl.dsp.window.resize()")
              { mouse = true; }
            ];
          }
        ];
      };
    };
  };
}
