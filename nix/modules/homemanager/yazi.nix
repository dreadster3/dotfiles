{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.yazi;
in {
  options = {
    modules.homemanager.yazi = {
      enable = mkEnableOption "yazi";
      package = mkOption {
        type = types.package;
        default = pkgs.yazi;
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      poppler # PDF preview
      fd # File search
      ripgrep # File content search
      resvg # SVG preview
      jq # JSON preview
      unzip # Archive preview
      ffmpeg # Video thumbnail
    ];

    modules.homemanager.zoxide.enable = mkDefault true;

    programs.yazi = {
      enable = true;
      inherit (cfg) package;
      shellWrapperName = "y";
      plugins = {
        inherit (pkgs.yaziPlugins)
          diff git mount lsar chmod smart-enter smart-filter;
      };
      initLua = ''
        require("git"):setup()
      '';
      settings = {
        plugin.prepend_fetchers = [
          {

            id = "git";
            name = "*";
            run = "git";
          }
          {

            id = "git";
            name = "*/";
            run = "git";
          }
        ];

      };
      keymap = {
        manager.prepend_keymap = [
          {
            on = "<C-d>";
            run = "plugin diff";
            desc = "Diff the selected with the hovered file";
          }
          {
            on = "M";
            run = "plugin mount";
            desc = "Mount manager";
          }
          {
            on = [ "r" "n" ];
            run = "rename";
            desc = "Rename the file";
          }
          {
            on = [ "r" "m" ];
            run = "plugin chmod";
            desc = "Chmod the file or folder";
          }
          {
            on = "l";
            run = "plugin smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = "F";
            run = "plugin smart-filter";
            desc = "Smart filter";
          }
        ];
      };
    };
  };
}
