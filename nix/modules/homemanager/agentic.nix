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
      # Coding Agents
      llm-agents.pi

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

    modules.homemanager.pi-web.enable = true;
  };
}
