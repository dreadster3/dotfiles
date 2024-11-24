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

    sops
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets.openai_api_key = { };
  };

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
      not-when-fullscreen = true;

      timers = [
        {
          delay = 5 * 60;
          command =
            "${pkgs.libnotify}/bin/notify-send 'Inactive' 'Locking session in 5 minutes'";
          canceller =
            "${pkgs.libnotify}/bin/notify-send 'Activity detected' 'Lock session cancelled'";
        }
        {
          # Lock the session after 10 min idle
          delay = 10 * 60;
          command = "loginctl lock-session";
        }
        {
          # Suspend the system after 15 min idle
          delay = 15 * 60;
          command = "systemctl suspend";
        }
      ];
    };
  };

  modules.homemanager = {
    settings = {
      font = {
        package = pkgs.nerdfonts.override {
          fonts = [ "Mononoki" "FiraCode" "VictorMono" "Iosevka" ];
        };
        normal.style = "Bold";
        italic.family = "VictorMono Nerd Font";
      };
    };

    stylix.enable = true;

    direnv.enable = true;
    bat.enable = true;
    alacritty.enable = true;
    kitty.enable = true;
    sxhkd.enable = true;
    zsh.enable = true;
    xdg.enable = true;
    neovim = {
      enable = true;
      package = lib.mkDefault pkgs.unstable.neovim-unwrapped;
      go = lib.mkDefault {
        enable = true;
        package = pkgs.unstable.go;
        languageServer = {
          enable = true;
          package = pkgs.unstable.gopls;
        };
      };
      rust = lib.mkDefault { enable = true; };
      python = lib.mkDefault {
        enable = true;
        package = pkgs.unstable.python3;
        poetry = {
          enable = true;
          package = pkgs.unstable.poetry;
        };
      };
    };
    btop.enable = true;
    ranger.enable = true;
    tmux.enable = true;
    lazygit.enable = true;
    bitwarden.enable = true;

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
