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

      set -gF window-status-format "#[fg=#{@catppuccin_window_number_color},bg=default]"
      set -agF window-status-format "#[fg=#{@thm_crust},bg=#{@catppuccin_window_number_color}]#{@catppuccin_window_number}"
      set -agF window-status-format "#{E:@catppuccin_window_middle_separator}"
      set -agF window-status-format "#[fg=#{@thm_fg},bg=#{@catppuccin_window_text_color}]#{@catppuccin_window_text}#{@_ctp_w_flags}"
      set -agF window-status-format "#[fg=#{@catppuccin_window_text_color},bg=default]"

      set -gF window-status-current-format "#[fg=#{@catppuccin_window_current_number_color},bg=default]"
      set -agF window-status-current-format "#[fg=#{@thm_crust},bg=#{@catppuccin_window_current_number_color}]#{@catppuccin_window_number}"
      set -agF window-status-current-format "#{E:@catppuccin_window_middle_separator}"
      set -agF window-status-current-format "#[fg=#{@thm_fg},bg=#{@catppuccin_window_text_color}]#{@catppuccin_window_text}#{@_ctp_w_flags}"
      set -agF window-status-current-format "#[fg=#{@catppuccin_window_text_color},bg=default]"

      set -g status-bg default
      set -g status-style bg=default
    '';

    catppuccin.tmux.extraConfig = ''
      set -g @catppuccin_status_background "default"

      set -g @catppuccin_pane_active_border_style "##{?pane_in_mode,fg=#{@thm_${accent}},##{?pane_synchronized,fg=#{@thm_blue},fg=#{@thm_${accent}}}}"
      set -g @catppuccin_window_text " #W"
      set -g @catppuccin_window_current_text " #{b:pane_current_path}"
      set -g @catppuccin_window_current_number "#F"
      set -g @catppuccin_window_current_number_color "#{@thm_${accent}}"

      set -g @catppuccin_window_status_style "rounded"
    '';

    # set -g @catppuccin_window_left_separator "#[fg=#{@_ctp_status_bg},bg=default,reverse]#[none]"
    # set -g @catppuccin_window_middle_separator " "
    # set -g @catppuccin_window_right_separator "#[fg=#{@_ctp_status_bg},bg=default,reverse]#[none]"
    # set -g status-bg default
    # set -g status-style bg=default

  };
}
