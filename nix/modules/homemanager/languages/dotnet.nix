{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.dotnet;
in
{
  options = {
    modules.homemanager.languages.dotnet = {
      enable = mkEnableOption "dotnet toolchain";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ dotnet-sdk ];

    home.sessionVariables.DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };
}
