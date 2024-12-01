{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.pipewire;
in {
  options = {
    modules.nixos.pipewire = { enable = mkEnableOption "pipewire"; };
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
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

  };
}
