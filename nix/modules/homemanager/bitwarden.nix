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
    # TODO: remove this when upstream fix is released
    nixpkgs.config.permittedInsecurePackages = [
      "electron-39.8.10"
    ];

    home.packages = with pkgs; [
      bitwarden-cli
      bitwarden-desktop
    ];
  };

}
