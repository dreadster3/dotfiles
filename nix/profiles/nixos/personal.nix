{ pkgs, ... }: {
  imports = [ ./common.nix ];

  security.pki.certificateFiles = [ ../../../certificates/issuer.crt ];

  # Run appimages directly
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [ eog firefox ntfs3g ];

  modules.nixos = {
    archive.enable = true;
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
