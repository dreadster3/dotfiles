{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.homemanager.neovim;
in {
  options = {
    modules.homemanager.neovim = {
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

    # With nix flakes, this cannot be used as updates will not work
    # xdg.configFile."nvim" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ../../../configurations/nvim;
    # };

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

          # For octo plugin
          gh

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
  };
}
