{ config, lib, pkgs, ... }: {
  imports = [ ../users.nix ];

  home-manager.users.dreadster = {
    imports = [ ../../profiles/homemanager/personal.nix ];

    nixpkgs.config.cudaSupport = true;

    modules.homemanager = {
      firefox.enable = true;
      pentest.enable = true;
    };

    programs.home-manager.enable = true;

    home.stateVersion = "24.11";
  };
}

