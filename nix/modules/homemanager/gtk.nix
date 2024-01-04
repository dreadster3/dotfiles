{config, lib, pkgs, ...}:
with lib;
let
	cfg = config.modules.gtk;
	capitalize = str: concatImapStrings(pos: x: if pos == 1 then (toUpper x) else x) (stringToCharacters str);

in
{
	options = {
		modules.gtk = {
			enable = mkEnableOption "gtk";
			variant = mkOption {
				type = types.str;
				default = "mocha";
				description = ''
					Variant for GTK catppuccin theme.
				'';
			};
			accent = mkOption {
				type = types.str;
				default = "blue";
				description = ''
					Accent color for GTK catppuccin theme.
				'';
			};
		};
	};
	config = mkIf cfg.enable {
		home.packages = with pkgs; [
			dconf
		];
		gtk = {
			enable = true;
			theme = {
				package = pkgs.catppuccin-gtk.override {
					accents = [cfg.accent];
					variant = cfg.variant;
				};
				name = "Catppuccin-${capitalize cfg.variant}-Standard-${capitalize cfg.accent}-Dark";
			};
		};
	};
}
