{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.git;
in
{
  options = {
    modules.homemanager.git = {
      enable = mkEnableOption "git";
      package = mkPackageOption pkgs "gitFull" { };
      username = mkOption {
        type = types.str;
        default = config.home.username;
      };
      email = mkOption { type = types.str; };
      signing = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "git.signing";
            format = mkOption {
              type = types.nullOr (
                types.enum [
                  "opengpg"
                  "ssh"
                ]
              );
              default = "ssh";
              description = "The format to use for signing commits";
            };
            key = mkOption {
              type = types.nullOr types.str;
              default = null;
            };
          };
        };
        default = { };
        description = "Sign commits with git";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      signing = mkIf cfg.signing.enable {
        inherit (cfg.signing) format key;
        signByDefault = true;
      };
      settings = {
        user = {
          inherit (cfg) email;
          name = cfg.username;
        };
      };
    };
  };
}
