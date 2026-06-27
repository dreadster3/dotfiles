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
      pi

      # Code Review
      coderabbit-cli

      # Utilities
      # agent-browser
      rtk

      # Pi Sandboxing
      pkgs.bubblewrap
      pkgs.socat
      # Fetch open source code
      pkgs.opensrc
    ];
  };
}
