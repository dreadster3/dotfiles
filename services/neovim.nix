{config, lib, pkgs, username, ...}:
with lib;
let
	cfg = config.customservices.neovim;
in
{
	config = {
		environment = {
			variables = {
				EDITOR = "nvim";
			};
		};

		home-manager.users = {
			"${username}" = {pkgs, ...}: {
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
		};
	};
}
