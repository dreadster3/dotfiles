{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nixos.steam;
in {
  options = { modules.nixos.steam = { enable = mkEnableOption "steam"; }; };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [ mangohud vulkan-tools ];
  };
}
