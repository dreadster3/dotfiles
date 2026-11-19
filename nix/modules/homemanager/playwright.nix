{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.playwright;

  playwright-driver = pkgs.playwright-driver;
  playwright-browsers = playwright-driver.browsers;
  browsersJSON =
    (builtins.fromJSON (builtins.readFile "${playwright-driver}/browsers.json")).browsers;
  chromium-rev = (builtins.head (builtins.filter (x: x.name == "chromium") browsersJSON)).revision;
  chromium-headless-rev =
    (builtins.head (builtins.filter (x: x.name == "chromium-headless-shell") browsersJSON)).revision;
  firefox-rev = (builtins.head (builtins.filter (x: x.name == "firefox") browsersJSON)).revision;
in
{
  options = {
    modules.homemanager.playwright = {
      enable = mkEnableOption "playwright";
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      PLAYWRIGHT_BROWSERS_PATH = "${playwright-browsers}";
      PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = true;
      PLAYWRIGHT_HOST_PLATFORM_OVERRIDE = "ubuntu-24.04";
    };

    home.sessionPath = [
      "${playwright-browsers}/chromium-${chromium-rev}/chrome-linux64"
      "${playwright-browsers}/firefox-${firefox-rev}/firefox"
      "${playwright-browsers}/chromium_headless_shell-${chromium-headless-rev}/chrome-headless-shell-linux64"
    ];

    home.packages = with pkgs; [
      playwright-browsers
      playwright-test
      playwright-mcp
    ];

    systemd.user.services.playwright-mcp = {
      Unit = {
        Description = "Playwright MCP server";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };

      Service = {
        ExecStart = "${lib.getExe pkgs.playwright-mcp} --isolated --port 8931";
        # Explicit env: home.sessionVariables only reaches the user manager via
        # environment.d at login, which can be stale after a home-manager switch.
        Environment = [
          "PLAYWRIGHT_BROWSERS_PATH=${playwright-browsers}"
          "PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true"
          "PLAYWRIGHT_HOST_PLATFORM_OVERRIDE=ubuntu-24.04"
        ];
        Restart = "always";
        RestartSec = 5;
      };
    };
  };
}
