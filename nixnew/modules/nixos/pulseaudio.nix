{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.pulseaudio;
in {
  options = {
    modules.nixos.pulseaudio = { enable = mkEnableOption "pulseaudio"; };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pavucontrol ];
    hardware.pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    sound = {
      enable = true;
      mediaKeys = {
        enable = true;
        volumeStep = "5%";
      };
    };
  };
}
