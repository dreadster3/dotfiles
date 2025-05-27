{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.catppuccin.tmux;
  inherit (config.catppuccin) accent enable;
in {
  options = { };

  config = mkIf (cfg.enable && enable) {
    programs.tmux.plugins = with pkgs.tmuxPlugins;
      lib.mkAfter [{
        plugin = cpu;
        extraConfig = ''
          set -g status-right "#{E:@catppuccin_status_host}"
          set -ag status-right "#{E:@catppuccin_status_application}"
          set -agF status-right "#{E:@catppuccin_status_cpu}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"

        '';
      }];

    programs.tmux.extraConfig = ''
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
    '';

    catppuccin.tmux.extraConfig = ''
      set -g @catppuccin_pane_active_border_style "##{?pane_in_mode,fg=#{@thm_${accent}},##{?pane_synchronized,fg=#{@thm_blue},fg=#{@thm_${accent}}}}"
      set -g @catppuccin_window_text " #W"
      set -g @catppuccin_window_current_text " #{b:pane_current_path}"
      set -g @catppuccin_window_current_number "#F"
      set -g @catppuccin_window_status_style "rounded"
    '';

  };
}
