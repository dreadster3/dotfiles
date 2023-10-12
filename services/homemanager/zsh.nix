{config, lib, pkgs, ...}:
{
	config = {
		home.packages = with pkgs; [
			zsh-powerlevel10k
		];

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
					{
						name = "zsh-nix-shell";
						file = "nix-shell.plugin.zsh";
						src = pkgs.fetchFromGitHub {
							owner = "chisui";
							repo = "zsh-nix-shell";
							rev = "v0.7.0";
							sha256 = "149zh2rm59blr2q458a5irkfh82y3dwdich60s9670kl3cl5h2m1";
						};
					}
				];
				oh-my-zsh = {
					enable = true;
					theme = "agnoster-nix";
					plugins = ["git" "sudo"];
					custom = "$HOME/Documents/projects/github/dotfiles/configurations/.oh-my-zsh/custom";
				};
				shellAliases = {
					n = "nvim ./";
					zshconfig = "nvim ~/Documents/projects/github/dotfiles/services/homemanager/zsh.nix";
					nvimconfig = "nvim ~/Documents/projects/github/dotfiles/configurations/nvim";
					nixconfig = "nvim ~/Documents/projects/github/dotfiles";
				};
			};
		};
	};
}
