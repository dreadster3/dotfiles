{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nixos.rustdesk;
in {
  options = {
    modules.nixos.rustdesk = { enable = mkEnableOption "rustdesk"; };
  };

  config = mkIf cfg.enable {

    services.rustdesk-server = {
      enable = true;
      openFirewall = true;
      signal = { enable = true; };
      relay = { enable = true; };
    };
  };
}
