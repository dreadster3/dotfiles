{ pkgs, config, lib, ... }: {
  environment.systemPackages = with pkgs; [ pavucontrol ];
  hardware.pulseaudio.enable = true;
  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
      volumeStep = "5%";
    };
  };
}
