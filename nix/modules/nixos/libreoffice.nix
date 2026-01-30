{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.libreoffice;
in
{
  options = {
    modules.nixos.libreoffice = {
      enable = mkEnableOption "libreoffice";
      spellingDictations = mkOption {
        type = types.listOf types.package;
        default = [
          pkgs.hunspellDicts.en_US
          pkgs.hunspellDicts.pt_PT
        ];
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
        libreoffice
        hunspell
      ]
      ++ cfg.spellingDictations;
  };
}
