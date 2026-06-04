{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.bitwarden;
in
{
  options = {
    modules.homemanager.bitwarden = {
      enable = mkEnableOption "bitwarden";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bitwarden-cli
      # (bitwarden-desktop.override { electron_39 = pkgs.electron_41; })
    ];
  };

}
