{ lib, ... }:
with lib; rec {
  monitor = types.submodule {
    options = {
      primary = mkOption {
        type = types.bool;
        default = false;
        description = "Whether this monitor is the default.";
      };
      resolution = mkOption {
        type = types.str;
        default = "preferred";
        description = "Resolution to use.";
      };
      position = mkOption {
        type = types.str;
        default = "auto";
        description = "Position to use.";
      };
      transform = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Transform to use.";
      };
      workspaces = mkOption {
        type = types.listOf types.int;
        default = [ ];
        description = "List of workspaces to configure.";
      };
      zoom = mkOption {
        type = types.either types.number types.str;
        default = "auto";
        description = "Zoom for monitor";
      };
    };
  };

  monitorMap = types.attrsOf monitor;
}
