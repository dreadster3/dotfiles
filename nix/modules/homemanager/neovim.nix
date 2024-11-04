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

  goPackages = optionals cfg.go.enable ([ cfg.go.package ]
    ++ optional cfg.go.languageServer.enable cfg.go.languageServer.package);

  rustPackages = optionals cfg.rust.enable [
    cfg.rust.package
    pkgs.cargo
    pkgs.rustfmt
    pkgs.rust-analyzer
  ];

  pythonPackages = optionals cfg.python.enable [
    (cfg.python.package.withPackages
      (ps: with ps; [ autopep8 autoflake flake8 ]))
    pkgs.djhtml
    (pkgs.poetry.override { python3 = cfg.python.package; })
  ];

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
      rust = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "neovim.rust";
            package = mkOption {
              type = types.package;
              default = pkgs.rustc;
            };
          };
        };
      };
      go = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "neovim.go";
            package = mkOption {
              type = types.package;
              default = pkgs.go;
            };
            languageServer = mkOption {
              type = types.submodule {
                options = {
                  enable = mkEnableOption "neovim.go.languageServer";
                  package = mkOption {
                    type = types.package;
                    default = pkgs.gopls;
                  };
                };
              };
            };
          };
        };
      };
      python = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "neovim.python";
            package = mkOption {
              type = types.package;
              default = pkgs.python3;
            };
          };
        };
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
        extraPackages = with pkgs;
          [
            # Depependencies
            unzip
            gcc
            cmake
            luarocks
            nodejs_20
            nodePackages.npm
            lazygit
            ripgrep
            dotnet-sdk_7
            nixfmt-classic
            gnumake
            terraform
            glow

            # For octo plugin
            gh

            # Install mason
            wget

            # Lua language server not working with mason
            lua-language-server
            stylua

            # Latex
            tex
            texlab

            # Bash
            beautysh
          ] ++ goPackages ++ rustPackages ++ pythonPackages;
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
