{config, lib, pkgs, ...}:
{
	imports = [
		./rofi
		./gtk.nix
		./zsh.nix
		./neovim.nix
		./polybar.nix
		./nerdfonts.nix
		./x11eventcallbacks.nix
		./kitty.nix
		./sxhkd.nix
	];
}

