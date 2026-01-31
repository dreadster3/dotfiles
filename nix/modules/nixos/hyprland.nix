{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.nixos.hyprland;
in
{
  options = {
    modules.nixos.hyprland = {
      enable = mkEnableOption "Hyprland";
      package = mkOption {
        type = types.package;
        default = pkgs.hyprland;
      };
      portalPackage = mkOption {
        type = types.package;
        default = pkgs.xdg-desktop-portal-hyprland;
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nwg-look
      nwg-displays
      wlr-randr

      qt5.qtwayland
      qt6.qtwayland
    ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      inherit (cfg) package portalPackage;
    };

    modules.nixos.sddm.enable = true;

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    home-manager.sharedModules = [
      {
        modules.homemanager = {
          hyprland = {
            enable = mkDefault true;
            package = mkDefault config.programs.hyprland.package;
            portalPackage = mkDefault config.programs.hyprland.portalPackage;
          };
          rofi.enable = mkDefault true;
          waybar.enable = mkDefault true;
          wlogout.enable = mkDefault true;
          hypridle.enable = mkDefault true;
          hyprlock.enable = mkDefault true;
          hyprpaper.enable = mkDefault true;
          polkit = {
            enable = mkDefault true;
            package = mkDefault pkgs.hyprpolkitagent;
          };
        };
      }
    ];
  };
}
