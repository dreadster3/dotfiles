{ config, lib, pkgs, ... }:
with lib;
let cfg = config.programs.regreet;
in {
  options = {
    programs.regreet = {
      cursorTheme = mkOption { type = types.any; };
      font = mkOption { type = types.any; };
      theme = mkOption { type = types.any; };
    };
  };
}
