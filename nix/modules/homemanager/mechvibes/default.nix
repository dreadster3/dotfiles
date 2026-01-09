{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.mechvibes;
  mechvibes = pkgs.callPackage ./derivation.nix { };
in
{
  options = {
    modules.homemanager.mechvibes = {
      enable = mkEnableOption "mechvibes";
      package = mkOption {
        type = types.package;
        default = pkgs.mechvibes;
        description = "The mechvibes package to use.";
      };
    };
  };

  config = mkIf cfg.enable {
    xsession.windowManager.bspwm.startupPrograms = [
      "${cfg.package}/bin/mechvibes --disable-seccomp-filter-sandbox"
    ];

    home.packages = [ cfg.package ];
    programs.zsh.shellAliases.mechvibes = "mechvibes --disable-seccomp-filter-sandbox";
  };

}
