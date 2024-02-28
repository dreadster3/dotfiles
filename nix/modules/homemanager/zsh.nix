{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.zsh;
in {
  options = { modules.zsh = { enable = mkEnableOption "zsh"; }; };
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
            src = pkgs.fetchFromGitHub {
              owner = "agkozak";
              repo = "zsh-z";
              rev = "585d1b2c5ad1ca0b21256db401382d751cc7b2a9";
              sha256 = "uch5w0xznHk2v/dwDSYAi80WqglYydb0zgwgJlIHW3U=";
            };
          }
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.7.0";
              sha256 = "149zh2rm59blr2q458a5irkfh82y3dwdich60s9670kl3cl5h2m1";
            };
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
