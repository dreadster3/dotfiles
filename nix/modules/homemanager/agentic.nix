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
    home.packages = with pkgs; [
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

    modules.homemanager.pi-web.enable = true;
  };
}
