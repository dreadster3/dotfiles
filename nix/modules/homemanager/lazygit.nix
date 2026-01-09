{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.lazygit;
in
{
  options = {
    modules.homemanager.lazygit = {
      enable = mkEnableOption "lazygit";
      package = mkOption {
        type = types.package;
        default = pkgs.lazygit;
        description = "The package to use for lazygit";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        os.editPreset = "nvim-remote";
        gui.nerdFontsVersion = 3;
      };
    };
  };

}
