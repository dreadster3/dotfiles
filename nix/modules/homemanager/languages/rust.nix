{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.rust;
in
{
  options = {
    modules.homemanager.languages.rust = {
      enable = mkEnableOption "rust toolchain";
      package = mkOption {
        type = types.package;
        default = pkgs.rustc;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cfg.package
      cargo
      clippy
      rustfmt
      rust-analyzer
    ];

    home.sessionPath = [ "${config.home.homeDirectory}/.cargo/bin" ];
  };
}
