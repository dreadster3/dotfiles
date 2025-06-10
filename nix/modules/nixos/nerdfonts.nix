{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.nixos.nerdfonts;
in {
  options = {
    modules.nixos.nerdfonts = { enable = mkEnableOption "nerdfonts"; };
  };
  config = mkIf cfg.enable {
    fonts.packages = with pkgs.nerd-fonts; [
      fira-code
      mononoki
      victor-mono
      pkgs.material-symbols
    ];
    fonts.fontconfig.enable = true;

    home-manager.sharedModules =
      [{ modules.homemanager.nerdfonts = { enable = true; }; }];
  };
}
