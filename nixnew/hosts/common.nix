{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    vim
    firefox
    git
    curl
    kitty
    alacritty
    foot

    piper

    # Wayland apps
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    networkmanagerapplet
  ];

  nixpkgs.config.allowUnfree = true;
}
