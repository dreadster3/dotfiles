{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.pulseaudio;
in {
  options = { modules.pulseaudio = { enable = mkEnableOption "pulseaudio"; }; };

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
