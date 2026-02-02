{ pkgs, inputs, ... }:
{
  imports = [ ../users.nix ];

  users.users.dreadster.extraGroups = [ "dialout" ];
  users.users.dreadster.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsZxq/uKw1n8bFeXo+Ez+YXbhWwu2AA2LHX3YD74MFU dreadster@termius"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC6akqtInNuSrkUIJFNHXRgzQhcWhuYBBp+nnwlkYmcS dreadster@termix"
  ];

  home-manager.users.dreadster = {
    imports = [
      ../../profiles/homemanager/personal.nix
      inputs.zen-browser.homeModules.beta
    ];

    programs.lutris = {
      enable = true;
      extraPackages = with pkgs; [
        # Genshin Impact
        libadwaita
        gtk4
        polkit
        mangohud

        # General
        vulkan-tools
      ];
    };

    home.packages = with pkgs; [
      prismlauncher
      remmina

      wineWowPackages.stable
      winetricks

      betterdiscordctl

      # HTTP client
      postman

      # IPTV
      hypnotix

      # Remote desktop
      # rustdesk-flutter INFO: waiting for https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues/252

      # AI companion
      shell-gpt
      claude-code
      codex

      # Terminal emulator
      warp-terminal

      # Note Self Hosted App
      affine
      joplin-desktop
    ];

    modules.homemanager = {
      settings = {
        monitors = {
          x11 = {
            DP-0 = {
              primary = true;
              workspaces = [
                1
                2
                3
                4
                5
              ];
            };
            HDMI-0 = {
              workspaces = [
                6
                7
                8
                9
                10
              ];
            };
          };

          wayland = {
            DP-1 = {
              primary = true;
              resolution = "preferred";
              position = "1080x0";
              transform = null;
              workspaces = [
                1
                2
                3
                4
                5
              ];
              zoom = "auto";
            };
            HDMI-A-1 = {
              resolution = "preferred";
              position = "0x0";
              transform = 1;
              workspaces = [
                6
                7
                8
                9
                10
              ];
              zoom = "auto";
            };
          };
        };
        font = {
          size = 22;
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
      };
      thunderbird.enable = true;
      gtk.enable = true;
      mangohud.enable = true;
      pentest.enable = true;
      easyeffects.enable = true;
      ollama.enable = true;
      obsidian.enable = true;

      # Hyprland
      hyprpaper.wallpapers = {
        "DP-1" = ../../../wallpapers/skirk.png;
        "HDMI-A-1" = ../../../wallpapers/gojo.png;
      };
    };

    programs.zen-browser.enable = true;
    xdg.mimeApps.defaultApplications = {
      "x-www-browser" = "zen-beta.desktop";
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "application/x-extension-htm" = "zen-beta.desktop";
      "application/x-extension-html" = "zen-beta.desktop";
      "application/x-extension-shtml" = "zen-beta.desktop";
      "application/xhtml+xml" = "zen-beta.desktop";
      "application/xhtml_xml" = "zen-beta.desktop";
      "application/x-extension-xhtml" = "zen-beta.desktop";
      "application/x-extension-xht" = "zen-beta.desktop";
    };

    home.stateVersion = "23.11";
  };
}
