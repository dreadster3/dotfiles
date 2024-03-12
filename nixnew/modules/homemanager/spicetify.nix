{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.modules.homemanager.spicetify;
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  catpuccin_theme =
    import ../../derivations/spicetify_catppuccin_theme.nix;

	spicetify = getExe pkgs.spicetify-cli;
in {

  options = {
    modules.homemanager.spicetify = { enable = mkEnableOption "spicetify-cli"; };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (final: prev: {
        spotify = prev.spotify.overrideAttrs (old: {
          postInstall = ''
            set -e
            export SPICETIFY_CONFIG="$out/share/spicetify"
            mkdir -p $SPICETIFY_CONFIG
			touch $out/prefs

            mkdir $SPICETIFY_CONFIG/Themes
            mkdir $SPICETIFY_CONFIG/Extensions
            mkdir $SPICETIFY_CONFIG/CustomApps

			cp -r "${catpuccin_theme}/catppuccin" "$SPICETIFY_CONFIG/Themes/"
			# Initialize config file
			${spicetify} config > /dev/null || true

			${getExe pkgs.gnused} -r -i "s|spotify_path( *)=.*|spotify_path\1= $out/share/spotify|g" "$SPICETIFY_CONFIG/config-xpui.ini"
			${getExe pkgs.gnused} -r -i "s|prefs_path( *)=.*|prefs_path\1= $out/prefs|g" "$SPICETIFY_CONFIG/config-xpui.ini"

			${spicetify} config current_theme "catppuccin"
			${spicetify} config current_theme "catppuccin"
			${spicetify} config color_scheme "mocha"
			${spicetify} config inject_css 1
			${spicetify} config inject_theme_js 1
			${spicetify} config replace_colors 1
			${spicetify} config overwrite_assets 1

			${spicetify} backup apply
          '';
        });
      })
    ];

    home.packages = with pkgs; [ spotify unstable.spicetify-cli ];
  };
}

