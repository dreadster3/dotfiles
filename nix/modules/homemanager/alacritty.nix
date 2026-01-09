{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.alacritty;
  inherit (config.modules.homemanager) settings;
in
{
  options = {
    modules.homemanager.alacritty = {
      enable = mkEnableOption "alacritty";
      package = mkOption {
        type = types.package;
        default = pkgs.alacritty;
      };
      yaml = mkEnableOption "alacritty.yaml";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ ueberzugpp ];

    programs.alacritty = {
      enable = true;
      inherit (cfg) package;
      settings = {
        # env = { "TERM" = "xterm-256color"; };
        font = { inherit (settings.font) size normal italic; };

        window = {
          padding = {
            x = 20;
            y = 20;
          };
          opacity = 0.6;
        };

        keyboard.bindings = [
          {
            key = "Return";
            mods = "Control|Shift";
            action = "SpawnNewInstance";
          }
        ];
      };
    };

    xdg.configFile."alacritty/alacritty.yml" =
      mkIf (config.programs.alacritty.settings != { } && cfg.yaml)
        {
          text = replaceStrings [ "\\\\" ] [ "\\" ] (builtins.toJSON config.programs.alacritty.settings);
        };

    xdg.configFile."xfce4/helpers.rc" = mkDefault { text = "TerminalEmulator=alacritty"; };

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/terminal" = mkDefault "Alacritty.desktop";
      "application/x-terminal-emulator" = mkDefault "Alacritty.desktop";
    };
  };
}
