{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [ outputs.homeManagerModules ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  home.packages = with pkgs; [
    killall
    tldr
    openssh
    feh
    wget
    curl
    zathura
    kubectl
    neofetch
    file
    fzf

    dig
    pciutils
    lshw
    usbutils
    ethtool

    tree
  ];

  home = {
    username = lib.mkDefault "dreadster";
    homeDirectory = lib.mkDefault "/home/dreadster";
  };

  home.sessionVariables = {
    XDG_CACHE_DIR = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    KUBECONFIG = "$HOME/.kube/config";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  services = {
    xidlehook = {
      enable = true;
      not-when-audio = true;

      timers = [{
        # Lock the session after 10 min idle
        delay = 10 * 60;
        command = "loginctl lock-session $XDG_SESSION_ID";
      }];
    };
  };

  modules.homemanager = {
    # nerdfonts.enable = true;
    stylix.enable = true;

    bat.enable = true;
    alacritty.enable = true;
    firefox.enable = true;
    kitty.enable = true;
    sxhkd.enable = true;
    zsh.enable = true;
    neovim = {
      enable = true;
      package = pkgs.unstable.neovim-unwrapped;
      go = pkgs.unstable.go;
    };
    btop.enable = true;
    ranger.enable = true;
    tmux.enable = true;
    lazygit.enable = true;

    # Not enabled defaults
    polybar.tray.enable = lib.mkDefault true;
    rofi.powermenu.enable = true;
  };

  systemd.user.startServices = "sd-switch";

  programs.git = {
    enable = true;
    userName = "dreadster3";
    userEmail = "afonso.antunes@live.com.pt";
  };
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
