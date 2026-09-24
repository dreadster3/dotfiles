{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.bash;
in
{
  options = {
    modules.homemanager.languages.bash = {
      enable = mkEnableOption "bash language tooling";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ beautysh ];
  };
}
