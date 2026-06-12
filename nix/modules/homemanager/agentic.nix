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
    home.packages = with pkgs.llm-agents; [
      # Coding Agents
      claude-code
      pi

      # Code Review
      coderabbit-cli

      # Utilities
      # agent-browser
      rtk
    ];
  };
}
