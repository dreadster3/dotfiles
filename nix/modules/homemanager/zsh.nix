{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.zsh;
in {
  options = { modules.homemanager.zsh = { enable = mkEnableOption "zsh"; }; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ zsh-powerlevel10k ];

    programs = {
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        sessionVariables = { "PATH" = "$PATH:$HOME/go/bin"; };
        plugins = [
          {
            name = "zsh-z";
            file = "share/zsh-z/zsh-z.plugin.zsh";
            src = pkgs.zsh-z;
          }
          {
            name = "zsh-nix-shell";
            file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
            src = pkgs.zsh-nix-shell;
          }
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
          {
            name = "powerlevel10k-config";
            src = ../../../configurations/powerlevel10k;
            file = "p10k.zsh";
          }
        ];
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "sudo" ];
          custom = "$HOME/.oh-my-zsh/custom";
        };
        shellAliases = {
          n = "nvim ./";
          zshconfig =
            "nvim ~/Documents/projects/github/dotfiles/nix/modules/homemanager/zsh.nix";
          nvimconfig =
            "nvim ~/Documents/projects/github/dotfiles/configurations/nvim";
          nixconfig = "nvim ~/Documents/projects/github/dotfiles";
        };
      };
    };
  };
}
