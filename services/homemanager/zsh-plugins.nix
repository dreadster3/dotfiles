{config, lib, pkgs, username, ...}:
with lib;
let
	cfg = config.customservices.zshplugins;
in
{
	config = {
		programs = {
			zsh = {
				enable = true;
				enableAutosuggestions = true;
				enableSyntaxHighlighting = true;
				plugins = [
					{
						name = "zsh-z";
						src = pkgs.fetchFromGitHub {
							owner = "agkozak";
							repo = "zsh-z";
							rev = "585d1b2c5ad1ca0b21256db401382d751cc7b2a9";
							sha256 = "uch5w0xznHk2v/dwDSYAi80WqglYydb0zgwgJlIHW3U=";
						};
					}
				];
				oh-my-zsh = {
					enable = true;
					theme = "robbyrussell";
					plugins = ["git" "sudo"];
				};
			};
		};
	};
}
