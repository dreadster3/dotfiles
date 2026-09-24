{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.languages.python;
in
{
  options = {
    modules.homemanager.languages.python = {
      enable = mkEnableOption "python toolchain";
      package = mkOption {
        type = types.package;
        default = pkgs.python3;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      (cfg.package.withPackages (
        ps: with ps; [
          debugpy
        ]
      ))
      pkgs.djhtml
    ];

    programs.uv.enable = true;
  };
}
