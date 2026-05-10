{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.neovim;

  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-medium
      pdfx
      xmpincl
      fontawesome5
      markdown
      paralist
      csvsimple
      tcolorbox
      environ
      tikzfill
      enumitem
      dashrule
      ifmtarg
      multirow
      changepage
      biblatex
      paracol
      roboto
      fontaxes
      lato
      ;
    #(setq org-latex-compiler "lualatex")
    #(setq org-preview-latex-default-process 'dvisvgm)
  };

  goPackages = optionals cfg.go.enable (
    [ cfg.go.package ] ++ optional cfg.go.languageServer.enable cfg.go.languageServer.package
  );

  rustPackages = optionals cfg.rust.enable [
    cfg.rust.package
    pkgs.cargo
    pkgs.clippy
    pkgs.rustfmt
    pkgs.rust-analyzer
  ];

  pythonPackages = optionals cfg.python.enable [
    (cfg.python.package.withPackages (
      ps: with ps; [
        debugpy
      ]
    ))
    pkgs.djhtml
  ];

  poetryPackage = cfg.python.poetry.package.override { python3 = cfg.python.package; };

  terminal = either cfg.terminal config.modules.homemanager.settings.terminal;
in
{
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
            poetry = mkOption {
              type = types.submodule {
                options = {
                  enable = mkEnableOption "neovim.python.poetry";
                  package = mkOption {
                    type = types.package;
                    default = pkgs.poetry;
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  config = mkIf cfg.enable {
    home = {
      # Glogal dependencies
      packages = with pkgs; [
        openssl
        pkg-config
        pnpm
        nodejs
        gh
        ripgrep
      ];

      sessionVariables = {
        EDITOR = "nvim";
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
        PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
        BUN_INSTALL = "${config.home.homeDirectory}/.local/share/bun";
        NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.local/share/npm";
      };

      sessionPath = [
        config.home.sessionVariables.PNPM_HOME
        "${config.home.sessionVariables.BUN_INSTALL}/bin"
        "${config.home.sessionVariables.NPM_CONFIG_PREFIX}/bin"
        "${config.home.homeDirectory}/go/bin"
        "${config.home.homeDirectory}/.cargo/bin"
      ];
    };

    # With nix flakes, this cannot be used as updates will not work
    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/projects/github/dotfiles/configurations/nvim";
    };

    modules.homemanager.poetry = mkIf cfg.python.poetry.enable {
      enable = true;
      package = poetryPackage;
    };

    programs.uv.enable = true;
    programs.bun.enable = true;

    programs.neovim = {
      enable = true;
      inherit (cfg) package;
      defaultEditor = true;
      sideloadInitLua = true;
      extraPackages =
        with pkgs;
        [
          # Depependencies
          unzip
          gcc
          cmake
          luarocks
          dotnet-sdk
          nixfmt
          gnumake
          terraform
          glow

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

          # nix
          nil
          statix
          deadnix

          # markdown
          marksman

          # For tree-sitter
          tree-sitter
        ]
        ++ goPackages
        ++ rustPackages
        ++ pythonPackages
        ++ lib.optionals (!config.programs.lazygit.enable) [ pkgs.lazygit ];
    };

    xdg.desktopEntries.neovim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "${getExe terminal} -e nvim %F";
      terminal = false;
      type = "Application";
      icon = "nvim";
      categories = [
        "Utility"
        "TextEditor"
      ];
    };
  };
}
