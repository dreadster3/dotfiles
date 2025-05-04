{ pkgs, ... }: {
  imports = [ ../users.nix ];

  home-manager.users.dreadster = {
    imports = [ ../../profiles/homemanager/personal.nix ];

    home.packages = with pkgs; [
      playerctl
      remmina

      wineWowPackages.stable
      winetricks

      betterdiscordctl

      qalculate-gtk
      gucharmap

      postman
      dbeaver-bin

      hypnotix
      pkgs.stable.rustdesk-flutter
    ];

    modules.homemanager = {
      settings = {
        monitors = {
          x11 = {
            DP-0 = {
              primary = true;
              workspaces = [ 1 2 3 4 5 ];
            };
            HDMI-0 = { workspaces = [ 6 7 8 9 10 ]; };
          };

          wayland = {
            DP-1 = {
              primary = true;
              resolution = "preferred";
              position = "1080x0";
              transform = null;
              workspaces = [ 1 2 3 4 5 ];
              zoom = "auto";
            };
            HDMI-A-1 = {
              resolution = "preferred";
              position = "0x0";
              transform = 1;
              workspaces = [ 6 7 8 9 10 ];
              zoom = "auto";
            };
          };
        };
      };

      openrgb = {
        enable = true;
        startup.enable = true;
      };
      dunst.enable = true;
      spotify = {
        enable = true;
        spicetify.enable = true;
        spicetify.package = pkgs.stable.spicetify-cli;
      };
      thunderbird.enable = true;
      gtk.enable = true;
      mangohud.enable = true;
      pentest.enable = true;
      easyeffects.enable = true;

      # Hyprland
      hyprpaper.wallpapers = {
        "DP-1" = ../../../wallpapers/skirk.png;
        "HDMI-A-1" = ../../../wallpapers/gojo.png;
      };
    };

    home.stateVersion = "23.11";
  };
}
