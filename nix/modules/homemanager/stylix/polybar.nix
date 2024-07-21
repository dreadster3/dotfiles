{ config, lib, ... }:
with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;
let
in {
  options.stylix.targets.polybar = {
    enable = config.lib.stylix.mkEnableTarget "polybar" true;
  };

  config =
    lib.mkIf (config.stylix.enable && config.stylix.targets.polybar.enable) {
      services.polybar.config.colorscheme = {
        background = "${base00}";
        mantle = "${base01}";
        surface0 = "${base02}";
        surface1 = "${base03}";
        surface2 = "${base04}";
        foreground = "${base05}";
        rosewater = "${base06}";
        lavender = "${base07}";
        red = "${base08}";
        peach = "${base09}";
        yellow = "${base0A}";
        green = "${base0B}";
        teal = "${base0C}";
        blue = "${base0D}";
        mauve = "${base0E}";
        flamingo = "${base0F}";
      };
    };
}
