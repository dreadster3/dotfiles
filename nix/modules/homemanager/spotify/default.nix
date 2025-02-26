{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.modules.homemanager.spotify;
  spicetify = getExe cfg.spicetify.package;
in {

  options = {
    modules.homemanager.spotify = {
      enable = mkEnableOption "spotify";
      package = mkOption {
        type = types.package;
        default = pkgs.spotify;
        description = "The package to install spotify";
      };
      spicetify = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "spotify.spicetify";
            package = mkOption {
              type = types.package;
              default = pkgs.spicetify-cli;
              description = "The package to install spicetify-cli";
            };
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = mkIf cfg.spicetify.enable [
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

            cp -r "${pkgs.spicetify_theme}/catppuccin" "$SPICETIFY_CONFIG/Themes/"
            # Initialize config file
            ${spicetify} config > /dev/null || true

            ${
              getExe pkgs.gnused
            } -r -i "s|spotify_path( *)=.*|spotify_path\1= $out/share/spotify|g" "$SPICETIFY_CONFIG/config-xpui.ini"
            ${
              getExe pkgs.gnused
            } -r -i "s|prefs_path( *)=.*|prefs_path\1= $out/prefs|g" "$SPICETIFY_CONFIG/config-xpui.ini"

            ${spicetify} config current_theme "catppuccin"
            ${spicetify} config color_scheme "mocha"
            ${spicetify} config inject_css 1
            ${spicetify} config inject_theme_js 1
            ${spicetify} config replace_colors 1
            ${spicetify} config overwrite_assets 1

            ${spicetify} apply
          '';
        });
      })
    ];

    home.packages = with pkgs;
      [ cfg.package ] ++ optional cfg.spicetify.enable cfg.spicetify.package;
  };
}
