{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.wofi;
in {
  options = { modules.homemanager.wofi = { enable = mkEnableOption "wofi"; }; };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
      settings = {
        width = 425;
        height = 250;
        show = "drun";
        prompt = "Search...";
        allow_markup = true;
        no_actions = true;
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 30;
        normal_window = true;
      };
      style =
        "	#window {\n		background-color: #1e1e2e;\n		border-radius: 8px;\n	}\n\n	#input {\n		border-radius: 8px;\n		margin: 6px;\n		border: none;\n		color: white;\n		background-color: #222235;\n	}\n\n	#inner-box {\n		margin: 8px;\n	}\n\n	#entry:selected {\n		background: rgba(137, 181, 250, .6);\n		color: white;\n	}\n\n	#text {\n		color: white;\n	}\n  ";
    };
  };
}
