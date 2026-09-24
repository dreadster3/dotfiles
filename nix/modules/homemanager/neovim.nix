{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.neovim;

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
    };
  };
  config = mkIf cfg.enable {
    home = {
      # Global build/dependency tools used by mason and language servers.
      # Language toolchains themselves live in modules.homemanager.languages.
      packages = with pkgs; [
        openssl
        pkg-config
        gh
        ripgrep
      ];

      sessionVariables = {
        EDITOR = "nvim";
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      };
    };

    # With nix flakes, this cannot be used as updates will not work
    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/projects/github/dotfiles/configurations/nvim";
    };

    programs.neovim = {
      enable = true;
      inherit (cfg) package;
      defaultEditor = true;
      sideloadInitLua = true;
      withRuby = false;
      withPython3 = false;

      # Make libsqlite3.so discoverable by LuaJIT ffi.load("sqlite3")
      # needed for snacks.nvim picker frecency DB on NixOS
      extraWrapperArgs = [
        "--suffix"
        "LD_LIBRARY_PATH"
        ":"
        "${lib.makeLibraryPath [
          pkgs.sqlite.out
        ]}"
      ];

      extraPackages =
        with pkgs;
        [
          # Editor-specific dependencies (mason, native builds, previews).
          # Language toolchains live in modules.homemanager.languages.
          unzip
          gcc
          cmake
          luarocks
          gnumake
          glow

          # Install mason
          wget

          # Latex preview via org mode needs the texlive bin on PATH; the
          # full latex toolchain (texlive, texlab, biber) is in languages.latex.
          ghostscript

          # Snacks.Image
          imagemagick
          mermaid-cli

          # For tree-sitter
          tree-sitter
        ]
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
