{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ];

  home.username = "dreadster";
  home.homeDirectory = "/home/dreadster";

  home.packages = with pkgs; [ killall tldr openssh feh wget curl ];

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
    nerdfonts.enable = true;
    kitty.enable = true;
    sxhkd.enable = true;
    zsh.enable = true;
    neovim.enable = true;
    btop.enable = true;
    ranger.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "dreadster3";
    userEmail = "afonso.antunes@live.com.pt";
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
