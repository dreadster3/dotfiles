{config, lib, pkgs, ...}:
with lib;
let
	cfg = config.customservices.neovim;
in
{
	config = {
		home.sessionVariables = {
			EDITOR = "nvim";
		};
		programs = {
			neovim = {
				enable = true;
				extraPackages = with pkgs; [
					gcc
					cmake
					luarocks
					nodejs
					lazygit
					rustc
					cargo
					ripgrep
				];
			};
		};
	};
}
