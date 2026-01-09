{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.zsh;
in
{
  options = {
    modules.nixos.zsh = {
      enable = mkEnableOption "zsh";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    environment.variables = {
      NIX_BUILD_SHELL = pkgs.zsh + "/bin/zsh";
    };
  };
}
