{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.zsh;
in {
  options = { modules.zsh = { enable = mkEnableOption "zsh"; }; };

  config = mkIf cfg.enable {
    programs = { zsh = { enable = true; }; };

    environment = { variables = { NIX_BUILD_SHELL = pkgs.zsh + "/bin/zsh"; }; };
  };
}
