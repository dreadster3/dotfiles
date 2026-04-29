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
      llm-agents.claude-code
      llm-agents.pi

      # Code Review
      llm-agents.coderabbit-cli

      # Utilities
      # llm-agents.agent-browser
    ];
  };
}
