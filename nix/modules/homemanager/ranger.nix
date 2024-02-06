{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.ranger;
in {
  options = {
    modules.ranger = {
      enable = mkEnableOption "ranger";
      previewMethod = mkOption {
        type = types.enum [ "iterm2" "ueberzug" ];
        default = "iterm2";
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [ ranger trash-cli ]
      ++ lib.optionals (cfg.previewMethod == "ueberzug") [ ueberzug ];

    xdg.configFile."ranger/rc.conf" = {
      text = ''
        set preview_images true
        set preview_images_method ${cfg.previewMethod}
        map DD shell trash-put %s'';
    };

    xdg.configFile."ranger/rifle.conf" = {
      text = ''label trash, has trash-put = trash-put -- "$@"'';
    };
  };
}
