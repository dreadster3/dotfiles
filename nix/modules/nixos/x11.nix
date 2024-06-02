{ config, pkgs, lib, ... }:
with lib;
let cfg = config.modules.nixos.x11;
in {
  options = { modules.nixos.x11 = { enable = mkEnableOption "X11"; }; };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb.layout = "us";
    };

    environment.systemPackages = with pkgs; [
      # Wallpapers
      nitrogen
      # Screenshots
      flameshot
      # Lockscreen
      betterlockscreen
      xclip
    ];
  };
}
