{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.homemanager.neovim;

  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-medium pdfx xmpincl fontawesome5 markdown paralist csvsimple
      tcolorbox environ tikzfill enumitem dashrule ifmtarg multirow changepage
      biblatex paracol roboto fontaxes lato;
    #(setq org-latex-compiler "lualatex")
    #(setq org-preview-latex-default-process 'dvisvgm)
  });

  terminal = either cfg.terminal config.modules.homemanager.settings.terminal;
in {
  options = {
    modules.homemanager.neovim = {
      enable = mkEnableOption "neovim";
      package = mkOption {
        type = types.package;
        default = pkgs.neovim-unwrapped;
      };
      terminal = mkOption {
        type = types.nullOr types.package;
        default = null;
      };
      go = mkOption {
        type = types.package;
        default = pkgs.go;
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
        package = cfg.package;
        extraPackages = with pkgs; [
          # Depependencies
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
          nixfmt-classic
          gnumake
          terraform
          glow

          # Golang
          cfg.go
          gopls

          # For octo plugin
          gh

          # Dependencies:
          # Install autopep8
          python3

          # Install mason
          wget

          # Lua language server not working with mason
          lua-language-server
          stylua

          # Latex
          tex
          texlab

          # Rust
          rustfmt
          rust-analyzer

          # Bash
          beautysh
        ];
      };
    };

    xdg.desktopEntries.neovim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "${getExe terminal} -e nvim %F";
      terminal = false;
      type = "Application";
      icon = "nvim";
      categories = [ "Utility" "TextEditor" ];
    };
  };
}
