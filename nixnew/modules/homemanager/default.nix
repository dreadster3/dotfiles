{ ... }: {
  imports = [ ./zsh.nix ./kitty.nix ./sxhkd.nix ./nerdfonts.nix ./neovim.nix ];

  nixpkgs.config.allowUnfree = true;
}
