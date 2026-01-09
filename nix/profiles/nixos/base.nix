{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    outputs.nixosModules
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  # Disable root password
  users.users.root.hashedPassword = "!";

  nix = {
    settings = {
      trusted-users = [ "@wheel" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    curl
    unzip
    zip
  ];

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

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = "bkp";
    sharedModules = [ inputs.catppuccin.homeModules.catppuccin ];
  };
}
