{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.neovim;
in {
  options = {
    modules.neovim = {
      enable = mkEnableOption "neovim";
      terminal = mkOption {
        type = types.package;
        default = pkgs.kitty;
      };
    };
  };
  config = mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
      DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
    };

    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink ../../../configurations/nvim;
    };

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
          gnumake
          terraform
          glow
          go

          # Dependencies:
          # Install autopep8
          python3

          # Install mason
          wget

          # Lua language server not working with mason
          lua-language-server
        ];
      };
    };

    xdg.desktopEntries.neovim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "${lib.getExe cfg.terminal} -e nvim %F";
      terminal = false;
      type = "Application";
      icon = "nvim";
      categories = [ "Utility" "TextEditor" ];
    };

    xdg.configFile.glow = {
      source = ../../../configurations/glow;
      recursive = true;
    };
  };
}
