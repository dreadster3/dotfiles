{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.pi-web;
in
{
  options = {
    modules.homemanager.pi-web = {
      enable = mkEnableOption "pi-web (Web UI for the pi coding agent)";

      package = mkOption {
        type = types.package;
        default = pkgs.pi-web;
        description = "The pi-web package to run.";
      };

      port = mkOption {
        type = types.port;
        default = 3000;
        description = "Port the pi-web server listens on.";
      };

      hostname = mkOption {
        type = types.str;
        default = "127.0.0.1";
        description = ''
          Address to bind. Loopback is the safe default; anything else is
          reachable on the network, so set {option}`passwordFile` too.
        '';
      };

      passwordFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = "/run/secrets/pi-web-password";
        description = "Optional file containing the PI_WEB_PASSWORD value.";
      };

      environment = mkOption {
        type = types.attrsOf types.str;
        default = { };
        example = {
          LITELLM_API_KEY = "$(cat /run/secrets/litellm_api_key)";
        };
        description = ''
          Extra environment variables for the service. Values are shell
          snippets evaluated at service start, so `$(cat /path/to/secret)`
          works. Needed by providers such as litellm, which read their
          credentials from the process environment rather than from pi's own
          settings; without this the service starts with no models configured.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # Loopback-only by default: the server is reachable from this user's
    # session without exposing the agent to the network.
    systemd.user.services.pi-web = {
      Unit = {
        Description = "pi-web — Web UI for the pi coding agent";
        After = [ "network.target" ];
      };

      Install = {
        WantedBy = [ "default.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = toString (
          pkgs.writeShellScript "pi-web-start" ''
            ${optionalString (cfg.passwordFile != null) ''
              PI_WEB_PASSWORD="$(cat ${cfg.passwordFile})"
              export PI_WEB_PASSWORD
            ''}
            ${optionalString (cfg.environment != { }) (
              concatStringsSep "\n" (mapAttrsToList (name: value: ''export ${name}="${value}"'') cfg.environment)
            )}
            exec ${lib.getExe cfg.package} --port ${toString cfg.port} --hostname ${cfg.hostname} --no-open
          ''
        );
        Environment = [
          "PI_WEB_NO_OPEN=1"
          # The UI is long-lived; don't let an idle timeout stop the service.
          "PI_WEB_IDLE_TIMEOUT_MS=0"
          "PI_WEB_SKIP_VERSION_CHECK=1"
        ];
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
