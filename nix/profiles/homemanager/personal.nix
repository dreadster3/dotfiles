{ inputs, outputs, config, lib, pkgs, ... }: {
  imports = [ ./common.nix inputs.sops-nix.homeManagerModules.sops ];

  home.packages = with pkgs; [
    feh
    zathura
    kubectl
    neofetch
    fzf
    tldr

    dig
    pciutils
    lshw
    usbutils
    ethtool

    pnpm-shell-completion

    sops
  ];

  sops = {
    defaultSopsFile = lib.mkDefault ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets.openai_api_key = { };
  };
  stylix.enable = true;

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

    gtk.enable = true;
    firefox.enable = true;
    ssh.enable = true;
    stylix.enable = true;
    direnv.enable = true;
    bat.enable = true;
    alacritty.enable = true;
    kitty.enable = true;
    zsh = {
      enable = true;
      dynamicEnvVariables = lib.mkDefault {
        openai_api_key = config.sops.secrets.openai_api_key.path;
      };
    };
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
    rofi.powermenu.enable = lib.mkDefault true;
  };

  systemd.user.startServices = "sd-switch";

  programs.git = {
    enable = true;
    userName = "dreadster3";
    userEmail = "afonso.antunes@live.com.pt";
  };
}
