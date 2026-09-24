{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.markdown;
in
{
  options = {
    modules.homemanager.languages.markdown = {
      enable = mkEnableOption "markdown language tooling";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ marksman ];
  };
}
