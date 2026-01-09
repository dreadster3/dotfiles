{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.storage;
in
{
  options = {
    modules.nixos.storage = {
      enable = mkEnableOption "storage";
    };
  };

  config = mkIf cfg.enable {
    nix.optimise = {
      automatic = true;
      dates = [ "3:00" ];
    };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
