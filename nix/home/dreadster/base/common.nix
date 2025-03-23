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

  home.packages = with pkgs; [ wget curl file tree ];

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

  modules.homemanager = {
    zsh.enable = true;
    btop.enable = true;
    tmux.enable = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
