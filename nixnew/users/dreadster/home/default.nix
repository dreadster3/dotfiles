{ config, lib, pkgs, ... }: {
  imports = [ ../../../modules/homemanager ];

  home.packages = with pkgs; [ killall tldr openssh feh wget curl ];

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

  programs.git = {
    enable = true;
    userName = "dreadster3";
    userEmail = "afonso.antunes@live.com.pt";
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
