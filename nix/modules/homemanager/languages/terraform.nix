{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.terraform;
in
{
  options = {
    modules.homemanager.languages.terraform = {
      enable = mkEnableOption "terraform tooling";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ terraform ];
  };
}
