{ hostname, inputs, outputs, config, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    outputs.nixosModules
    ./hardware-configuration.nix

    ../users.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  modules.nixos = { grub.enable = true; };

  time.timezone = "Europe/Lisbon";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  networking.networkmanager.enable = true;

  environemnt.systemPackages = with pkgs; [ wget vim git curl unzip zip ];

  networking.hostName = hostname;

  virtualisation.vmware.guest.enable = true;

  system.stateVersion = "24.11";
}
