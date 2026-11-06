{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.agentic;
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

    programs.zsh.shellAliases = {
      spi = "nono run --allow-cwd --profile pi -s -- pi $@";
    };

    home.packages = with pkgs; [
      # Sandboxing
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
