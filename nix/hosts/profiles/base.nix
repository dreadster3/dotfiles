{ inputs, outputs, config, lib, pkgs, ... }: {
  imports =
    [ inputs.home-manager.nixosModules.home-manager outputs.nixosModules ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  nix = {
    settings = {
      trusted-users = [ "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  environment.systemPackages = with pkgs; [ wget vim git curl unzip zip ];

  modules.nixos = {
    zsh.enable = true;
    storage.enable = true;
  };

  networking.firewall.enable = true;

  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_US.UTF-8";
  services.locate.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = [ ];
  };

  home-manager.extraSpecialArgs = { inherit inputs outputs; };
  home-manager.backupFileExtension = "bkp";
  home-manager.sharedModules =
    [ inputs.catppuccin.homeManagerModules.catppuccin ];
}
