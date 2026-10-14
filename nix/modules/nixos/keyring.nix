{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.keyring;
in
{
  options = {
    modules.nixos.keyring = {
      enable = mkEnableOption "keyring";
    };
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;
  };
}
