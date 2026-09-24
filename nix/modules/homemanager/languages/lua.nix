{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.lua;
in
{
  options = {
    modules.homemanager.languages.lua = {
      enable = mkEnableOption "lua language tooling";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lua-language-server
      stylua
    ];
  };
}
