{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.nix;
in
{
  options = {
    modules.homemanager.languages.nix = {
      enable = mkEnableOption "nix language tooling";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixfmt
      nil
      statix
      deadnix
    ];
  };
}
