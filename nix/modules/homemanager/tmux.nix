{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.tmux;
in {
  options = { modules.homemanager.tmux = { enable = mkEnableOption "tmux"; }; };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      catppuccin.enable = false;
      shell = "${pkgs.zsh}/bin/zsh";
      keyMode = "vi";
      prefix = "C-b";
      newSession = true;
      mouse = true;
      terminal = "tmux-256color";
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavour 'mocha'
            set -g @catppuccin_window_tabs_enabled 'on'
            set -g @catppuccin_date_time "%H:%M"
            set -g @catppuccin_window_left_separator ""
            set -g @catppuccin_window_right_separator " "
            set -g @catppuccin_status_modules_right "application cpu session host date_time"
          '';
        }
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-vim 'session'
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
            set -g @continuum-save-interval '10'
          '';
        }
        cpu
        better-mouse-mode
      ];
      extraConfig = ''
        bind-key v split-window -v
        bind-key h split-window -h
      '';
    };
  };
}
