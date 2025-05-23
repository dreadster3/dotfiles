{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.homemanager.tmux;
in {
  options = { modules.homemanager.tmux = { enable = mkEnableOption "tmux"; }; };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      keyMode = "vi";
      prefix = "C-b";
      newSession = true;
      mouse = true;
      terminal = "tmux-256color";
      escapeTime = 0;
      plugins = with pkgs.tmuxPlugins; [
        { plugin = resurrect; }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '10'
          '';
        }
        better-mouse-mode
        vim-tmux-navigator
        yank
        {
          plugin = tmux-thumbs;
          extraConfig = ''
            set -g @thumbs-unique enabled
          '';
        }
        tmux-fzf
        {
          plugin = tmux-sessionx;
          extraConfig = ''
            set -g @sessionx-bind 's'
            set -g @sessionx-filter-current 'false'
          '';
        }
      ];
      extraConfig = ''
        bind-key v split-window -v -c '#{pane_current_path}'
        bind-key h split-window -h -c '#{pane_current_path}'
      '';
    };
  };
}
