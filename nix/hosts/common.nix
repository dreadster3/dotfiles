{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    outputs.nixosModules
    ./users.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  # Run appimages directly
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    vim
    firefox
    git
    curl
    kitty
    alacritty
    openvpn
    networkmanagerapplet

    unzip

    clinfo

    gnome.eog
  ];

  modules.nixos = {
    grub.enable = true;
    thunar.enable = true;
    network.enable = true;
    pipewire.enable = lib.mkDefault true;
    zsh.enable = true;
    storage.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  services.locate.enable = true;

  security.polkit.enable = true;

  nix = {
    channel.enable = false;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home-manager.extraSpecialArgs = { inherit inputs outputs; };
}
