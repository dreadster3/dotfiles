{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.agentic;

  spi = pkgs.writeShellScriptBin "spi" ''
    # Split args: spi <pi args...> -- <extra nono run flags...>
    sep=0
    pi_args=()
    extra=()
    for a in "$@"; do
      if [ "$sep" = 1 ]; then
        extra+=("$a")
      elif [ "$a" = "--" ]; then
        sep=1
      else
        pi_args+=("$a")
      fi
    done
    exec env HERDR_AGENT=pi nono run --allow-cwd --profile pi "''${extra[@]}" -s -- pi "''${pi_args[@]}"
  '';
in
{
  options = {
    modules.homemanager.agentic = {
      enable = mkEnableOption "agentic";
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      SYSTEMONE_ENDPOINT = "https://openrouter.ai/api/alpha/decisions";
    };

    programs.herdr = {
      enable = true;
      settings = {
        onboarding = false;
        keys = {
          prefix = "ctrl+b";
          goto = "prefix+s";
          detach = "prefix+d";
          switch_tab = "prefix+1..9";
          switch_workspace = "prefix+shift+1..9";
          focus_agent = "prefix+alt+1..9";
        };
        terminal = {
          new_cwd = "follow";
        };
        theme = {
          name = "catppuccin";
        };
        ui = {
          toast = {
            delivery = "herdr";
            herdr = {
              position = "top-right";
            };
          };
        };
      };
    };

    home.packages = with pkgs; [
      # Sandboxing
      spi
      ripgrep
      socat
      bubblewrap
      libsecret
      llm-agents.nono

      # Coding Agents
      pi

      # Code Review
      llm-agents.coderabbit-cli

      # Utilities
      # agent-browser
      llm-agents.rtk
      llm-agents.codegraph
      pkgs.stable.playwright-mcp

      # Fetch open source code
      pkgs.opensrc
    ];
  };
}
