{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.steam;
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  options = { modules.steam = { enable = mkEnableOption "steam"; }; };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [ mangohud vulkan-tools ];
  };
}
