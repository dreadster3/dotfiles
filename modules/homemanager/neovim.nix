{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.neovim;
in {
  options = {
    modules.neovim = {
      enable = mkEnableOption "neovim";
      setDefaultEditor = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };
  config = mkIf cfg.enable {
    home.sessionVariables = { EDITOR = "nvim"; };
    programs = {
      neovim = {
        enable = true;
        extraPackages = with pkgs; [
          unzip
          gcc
          cmake
          luarocks
          nodejs_20
          nodePackages.npm
          lazygit
          rustc
          cargo
          ripgrep
          dotnet-sdk_7
          nixfmt
        ];
      };
    };
  };
}
