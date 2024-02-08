{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ];

  home.stateVersion = "18.09";

  home.packages = with pkgs; [ killall ];

  nixpkgs.config.allowUnfree = true;

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

  # Custom modules
  modules = {
    nerdfonts = { enable = true; };
    kitty = { enable = true; };
    btop = { enable = true; };
    wezterm = { enable = true; };
    neovim = { enable = true; };
    ranger = { enable = true; };
    zsh = { enable = true; };
    thunderbird = { enable = true; };
  };

  programs = {
    git = {
      enable = true;
      userName = "dreadster3";
      userEmail = "afonso.antunes@live.com.pt";
    };
  };
}
