{ config, lib, pkgs, ... }: {
  imports = [ ../modules/nixos ];

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
  ];

  modules.nixos = {
    grub.enable = true;
    thunar.enable = true;
    network.enable = true;
    pulseaudio.enable = true;
    zsh.enable = true;
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
    LC_TIME = "pt_PT.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.polkit.enable = true;

  networking.firewall = {
    enable = true;
    allowPing = false;
  };

  nixpkgs.config.allowUnfree = true;
}
