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

  modules.nixos = {
    grub.enable = true;
    zsh.enable = true;
    i3.enable = true;
  };

  time.timeZone = "Europe/Lisbon";
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

  environment.systemPackages = with pkgs; [ wget vim git curl unzip zip ];

  networking.hostName = hostname;

  virtualisation.vmware.guest.enable = true;

  home-manager.extraSpecialArgs = { inherit inputs outputs; };
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bkp";
  home-manager.sharedModules =
    [ inputs.catppuccin.homeManagerModules.catppuccin ];

  home-manager.users.dreadster = {
    imports = [ outputs.homeManagerModules ];

    nixpkgs = {
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages
      ];

      config.allowUnfree = true;
    };

    modules.homemanager = {
      alacritty.enable = true;
      zsh.enable = true;
    };

    home.stateVersion = "24.11";
  };

  system.stateVersion = "24.11";
}
