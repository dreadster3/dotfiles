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
      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.catppuccin
      ];
      extraConfig = ''
        set -g @catppuccin_flavour 'mocha'
      '';
    };
  };
}
