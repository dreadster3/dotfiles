{ inputs, config, lib, pkgs, ... }: {
  imports = [ ./common.nix inputs.sops-nix.homeManagerModules.sops ];

  home.packages = with pkgs; [
    feh
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
    nix-init

    sops
  ];

  sops = {
    defaultSopsFile = lib.mkDefault ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets.openai_api_key = { };
    secrets.anthropic_api_key = { };
  };

  modules.homemanager = {
    settings = {
      enable = true;
      font = {
        normal.style = "Bold";
        italic.family = "VictorMono Nerd Font";
      };
    };

    git = {
      enable = true;
      username = "dreadster3";
      email = "afonso.antunes@live.com.pt";
    };

    eog.enable = true;
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
        anthropic_api_key = config.sops.secrets.anthropic_api_key.path;
      };
    };
    neovim = {
      enable = true;
      go = lib.mkDefault {
        enable = true;
        languageServer.enable = true;
      };
      rust = lib.mkDefault { enable = true; };
      python = lib.mkDefault {
        enable = true;
        poetry.enable = true;
      };
    };
    yazi.enable = true;
    lazygit.enable = true;
    bitwarden.enable = true;
    zathura.enable = true;

    # Not enabled defaults
    polybar.tray.enable = lib.mkDefault true;
    rofi.powermenu.enable = lib.mkDefault true;
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    nh = {
      enable = true;
      flake =
        "${config.home.homeDirectory}/Documents/projects/github/dotfiles/nix";
    };
  };
}
