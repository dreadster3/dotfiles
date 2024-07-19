{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.homemanager.bspwm;

  monitors = cfg.monitors // { rdp0 = { workspaces = [ 1 2 3 4 5 ]; }; };

  fix_script = pkgs.writers.writeBash "fix_remote.sh" ''
    bspc wm --restart
    sleep 1
    bspc monitor MONITOR --remove
    bspc monitor rdp0 -d "1" "2" "3" "4" "5"
    MONITOR='rdp0' polybar --reload secondary &'';
in {
  options = {
    modules.homemanager.bspwm = {
      enable = mkEnableOption "bspwm";

      monitors = mkOption {
        type = types.monitorMap;
        description = "The monitors and their desktops";
        default = {
          DP-0 = {
            default = true;
            resolution = "preferred";
            position = "1080x0";
            transform = null;
            workspaces = [ 1 2 3 4 5 ];
            zoom = "auto";
          };
          HDMI-A-0 = {
            resolution = "preferred";
            position = "0x0";
            transform = 1;
            workspaces = [ 6 7 8 9 10 ];
            zoom = "auto";
          };
        };
      };

      startupPrograms = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "The startup programs";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.zsh.shellAliases.fix_remote = "${fix_script} & disown && exit";
    xsession.windowManager.bspwm = {
      enable = true;
      settings = {
        focused_border_color = "#89B4FA";
        border_width = 3;
        window_gap = 10;

        split_ratio = 0.5;
        borderless_monocle = true;
        gapless_monocle = true;

        pointer_follows_focus = false;
        focus_follows_pointer = true;

        right_padding = 0;
        bottom_padding = 0;
      };
      startupPrograms = cfg.startupPrograms ++ [
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "${getExe pkgs.nitrogen} --restore"
        "xsetroot -cursor_name left_ptr"
      ];

      monitors = mapAttrs
        (name: monitor: (map (value: toString value) monitor.workspaces))
        monitors;

      rules = {
        "Pavucontrol" = {
          state = "floating";
          center = true;
        };
        ".guake-wrapped" = {
          state = "floating";
          sticky = true;
          center = true;
        };
        "Zathura" = { state = "tiled"; };
        "GeForce NOW" = { state = "fullscreen"; };
      };
    };
  };

}
