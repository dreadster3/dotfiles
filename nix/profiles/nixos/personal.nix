{ pkgs, ... }:
{
  imports = [ ./common.nix ];

  security.pki.certificateFiles = [
    ../../../certificates/rootca.crt
    ../../../certificates/homeissuer.crt
    ../../../certificates/truenasca.crt
  ];

  # Run appimages directly
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  powerManagement.enable = true;

  environment.systemPackages = with pkgs; [
    eog # Image viewer
    firefox # Web browser
    ntfs3g # NTFS utilities
    qalculate-gtk # Calculator
    gucharmap # Character map
    playerctl # Media player controller
    dig # DNS lookup
    gpu-screen-recorder-gtk # Screen recorder

    unixtools.net-tools # Network tools
  ];

  modules.nixos = {
    archive.enable = true;
    dconf.enable = true;
    qt.enable = true;
    catppuccin.enable = true;
    thunar.enable = true;
    network.enable = true;
    sound.enable = true;
    stylix.enable = true;
    nerdfonts.enable = true;
  };

  i18n.extraLocaleSettings = {
    LC_ALL = "en_US.UTF-8";
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  security.polkit.enable = true;
  environment.etc.hosts.mode = "0744";
}
