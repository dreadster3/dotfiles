{ outputs, inputs, lib, pkgs, ... }: {
  imports =
    [ outputs.homeManagerModules inputs.spicetify.homeManagerModules.default ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  home = {
    username = lib.mkDefault "dreadster";
    homeDirectory = lib.mkDefault "/home/dreadster";

    packages = with pkgs; [ wget curl file tree ];

    sessionVariables = {
      # XDG_CACHE_DIR = "$HOME/.cache";
      # XDG_CONFIG_HOME = "$HOME/.config";
      # XDG_DATA_HOME = "$HOME/.local/share";
      KUBECONFIG = "$HOME/.kube/config";
    };
  };

  xdg.enable = true;
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
}
