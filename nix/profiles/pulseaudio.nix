{ pkgs, config, lib, ... }: {
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
}
