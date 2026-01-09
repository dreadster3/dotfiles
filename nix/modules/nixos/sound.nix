{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.sound;
in
{
  options = {
    modules.nixos.sound = {
      enable = mkEnableOption "sound";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pavucontrol ];

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
