{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.wofi;
in {
  options = { modules.wofi = { enable = mkEnableOption "wofi"; }; };

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
	  style = ''
		#window {
			background-color: #1e1e2e;
			border-radius: 8px;
		}

		#input {
			border-radius: 8px;
			margin: 6px;
			border: none;
			color: white;
			background-color: #222235;
		}

		#inner-box {
			margin: 8px;
		}

		#entry:selected {
			background: rgba(137, 181, 250, .6);
			color: white;
		}

		#text {
			color: white;
		}
	  '';
    };
  };
}
