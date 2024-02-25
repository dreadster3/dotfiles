{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.bspwm;

  fix_script = pkgs.writers.writeBash "fix_remote.sh" ''
    bspc wm --restart
    sleep 1
    bspc monitor MONITOR --remove
    bspc monitor rdp0 -d "1" "2" "3" "4" "5"
    MONITOR='rdp0' polybar --reload secondary &'';
in {
  options = {
    modules.bspwm = {
      enable = mkEnableOption "bspwm";

      monitor = mkOption {
        type = types.str;
        default = "DP-0";
        description = "The monitor to use for bspwm";
      };

      monitors = mkOption {
        type = types.attrsOf (types.listOf types.str);
        default = { DP-0 = [ "1" "2" "3" "4" "5" ]; };
        description = "The monitors and their desktops";
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
        "${getExe pkgs.sxhkd}"
        "${getExe pkgs.nitrogen} --restore"
        "xsetroot -cursor_name left_ptr"
      ];

      monitors =
        lib.mkMerge [ ({ rdp0 = [ "1" "2" "3" "4" "5" ]; }) cfg.monitors ];

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
      };
    };
  };

}
