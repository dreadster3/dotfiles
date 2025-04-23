{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.homemanager.direnv;
in {
  options = {
    modules.homemanager.direnv = {
      enable = mkEnableOption "direnv";
      package = mkOption {
        type = types.package;
        default = pkgs.direnv;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      stdlib = ''
        layout_poetry() {
          if [[ ! -f pyproject.toml ]]; then
            log_error 'No pyproject.toml found. Use `poetry new` or `poetry init` to create one first.'
            exit 2
          fi

          local VENV=$(poetry env info --path)
          if [[ -z $VENV || ! -d $VENV/bin ]]; then
            log_error 'No poetry virtual environment found. Use `poetry install` to create one first.'
            exit 2
          fi

          export VIRTUAL_ENV=$VENV
          export POETRY_ACTIVE=1
          PATH_add "$VENV/bin"
        }
      '';
    };
  };
}
