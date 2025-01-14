{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [ ./common.nix inputs.sops-nix.homeManagerModules.sops ];

  home.packages = with pkgs; [
    feh
    zathura
    kubectl
    neofetch
    fzf

    dig
    pciutils
    lshw
    usbutils
    ethtool
    chromium

    sops
  ];

  sops = {
    defaultSopsFile = lib.mkDefault ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets.openai_api_key = { };
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
      enable = true;
      font = {
        package = pkgs.nerdfonts.override {
          fonts = [ "Mononoki" "FiraCode" "VictorMono" "Iosevka" ];
        };
        normal.style = "Bold";
        italic.family = "VictorMono Nerd Font";
      };
    };
    ssh.enable = true;

    stylix.enable = true;

    direnv.enable = true;
    bat.enable = true;
    alacritty.enable = true;
    kitty.enable = true;
    sxhkd.enable = true;
    zsh = {
      enable = true;
      dynamicEnvVariables = lib.mkDefault {
        open_api_key = config.sops.secrets.openai_api_key.path;
      };
    };
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
    ranger.enable = true;
    lazygit.enable = true;
    bitwarden.enable = true;

    # Not enabled defaults
    polybar.tray.enable = lib.mkDefault true;
    rofi.powermenu.enable = true;
  };

  systemd.user.startServices = "sd-switch";
  stylix.enable = true;

  programs.git = {
    enable = true;
    userName = "dreadster3";
    userEmail = "afonso.antunes@live.com.pt";
  };

  home.stateVersion = "23.11";
}
