{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.homemanager.zsh;

  dynamicEnvVariables =
    foldlAttrs (_: name: value: "export ${toUpper name}=$(cat ${value})") ""
    cfg.dynamicEnvVariables;
in {
  options = {
    modules.homemanager.zsh = {
      enable = mkEnableOption "zsh";
      sourceNix = mkEnableOption "zsh.sourceNix";

      dynamicEnvVariables = mkOption {
        type = types.attrsOf types.str;
        default = { };
      };
    };
  };
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      sessionVariables = { "PATH" = "$PATH:$HOME/go/bin:$HOME/.cargo/bin"; };
      initExtra = concatStringsSep "\n" ([ dynamicEnvVariables ]
        ++ optional cfg.sourceNix
        "source $HOME/.nix-profile/etc/profile.d/nix.sh");
      plugins = [
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
      ] ++ optional (!config.programs.zoxide.enable) {
        name = "zsh-z";
        file = "share/zsh-z/zsh-z.plugin.zsh";
        src = pkgs.zsh-z;
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "alias-finder"
          "common-aliases"
          "emoji"
          "git"
          "sudo"
          "tmux"
          "terraform"
          "golang"
          "rust"
        ];
        custom = "$HOME/.oh-my-zsh/custom";
      };
      shellAliases = {
        n = "nvim";
        zshconfig =
          "nvim ~/Documents/projects/github/dotfiles/nix/modules/homemanager/zsh.nix";
        nvimconfig =
          "nvim ~/Documents/projects/github/dotfiles/configurations/nvim";
        nixconfig = "nvim ~/Documents/projects/github/dotfiles";
        ssh = "TERM=xterm-256color ${pkgs.openssh}/bin/ssh";
      };
    };
  };
}
