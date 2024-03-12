{ config, lib, pkgs, ... }:
let
  primaryMonitor = "Virtual1";
  secondaryMonitor = "Virtual2";
in {
  imports = [ ./default.nix ];

  home.sessionVariables = {
    XDG_CACHE_DIR = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
  };

  xdg.userDirs = {
	  enable = true;
	  createDirectories = true;
  }
}
