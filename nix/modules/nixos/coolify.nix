# WARNING: NOT PRODUCTION READY
{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.nixos.coolify;

  coolifyEnv = {
    APP_ID = "13f69a0231f450d4ff7db76edd8d2322";
    APP_ENV = "production";
    APP_KEY = "base64:ZwSTIxr89ncD0ecpliOuLCL6xKqcch3hyx+VqmWB6vs=";
    DB_USERNAME = "coolify";
    DB_PASSWORD = "coolify";
    REDIS_PASSWORD = "coolify";
    PUSHER_APP_ID =
      "b651633bf5766d96ef55fb7786eb96b306f76668afb670e71c375b4438a39286";
    PUSHER_APP_KEY =
      "0a71429ad3f6500efefdc5eae3c3cad0b3359d28dac5a83cb7456b16168e93e4";
    PUSHER_APP_SECRET =
      "ca8ac45c8e73862608fc5746de2080bf9746ea6f385e38e0dbdbfb8147ce103b";
    SSL_MODE = "off";
  };

  envFile = pkgs.writeText ".env" (foldlAttrs (acc: name: value:
    acc + ''
      ${name}=${value}
    '') "" coolifyEnv);
in {
  options = {
    modules.nixos.coolify = {
      enable = mkEnableOption "coolify";
      image = mkOption {
        type = types.str;
        default = "latest";
      };
      port = mkOption {
        type = types.int;
        default = 8000;
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.virtualisation.docker.enable;
      message = "coolify requires docker";
    }];

    system.activationScripts.coolify = ''
      mkdir -p /data
      chown root:root /data
      mkdir -p /data/coolify/{source,ssh,applications,databases,backups,services,proxy,webhooks-during-maintenance}
      mkdir -p /data/coolify/ssh/{keys,mux}
      mkdir -p /data/coolify/proxy/dynamic
      chown 9999:9999 -R /data/coolify
    '';

    users.groups.coolify = { gid = 9999; };
    users.users.coolify = {
      isSystemUser = true;
      home = "/data/coolify";
      createHome = true;
      group = "coolify";
      extraGroups = [ "docker" ];
      hashedPassword = "!";
      uid = 9999;
    };

    services.openssh = {
      enable = true;
      settings = { PermitRootLogin = "prohibit-password"; };
    };

    virtualisation.oci-containers.backend = "docker";
    virtualisation.oci-containers.containers = {
      coolify = {
        image = "ghcr.io/coollabsio/coolify:${cfg.image}";
        autoStart = true;
        environment = coolifyEnv;
        ports = [ "${toString cfg.port}:80" ];
        hostname = "coolify";
        dependsOn = [ "postgres" "redis" "soketi" ];
        extraOptions = [
          "--health-cmd='curl --fail http://127.0.0.1:80/api/health || exit 1'"
          "--health-interval=30s"
          "--health-retries=3"
          "--health-timeout=20s"
          "--network=coolify"
          "--add-host=host.docker.internal:host-gateway"
          "--expose=8000"
        ];
        workdir = "/var/www/html";
        volumes = [
          "/data/coolify/source/.env:/var/www/html/.env:ro"
          "/data/coolify/ssh:/var/www/html/storage/app/ssh"
          "/data/coolify/applications:/var/www/html/storage/app/applications"
          "/data/coolify/databases:/var/www/html/storage/app/databases"
          "/data/coolify/services:/var/www/html/storage/app/services"
          "/data/coolify/backups:/var/www/html/storage/app/backups"
          "/data/coolify/webhooks-during-maintenance:/var/www/html/storage/app/webhooks-during-maintenance"
        ];
      };
      postgres = {
        image = "postgres:15-alpine";
        hostname = "postgres";
        autoStart = true;
        environment = {
          POSTGRES_USER = "coolify";
          POSTGRES_PASSWORD = "coolify";
          POSTGRES_DB = "coolify";
        };
        volumes = [ "coolify_data:/var/lib/postgresql/data" ];
        extraOptions = [
          "--health-cmd='pg_isready -U coolify -d coolify'"
          "--health-interval=30s"
          "--health-retries=3"
          "--health-timeout=20s"
          "--network=coolify"
        ];
      };
      redis = {
        image = "redis:alpine";
        hostname = "coolify-redis";
        autoStart = true;
        cmd = [
          "redis-server"
          "--save"
          "20"
          "1"
          "--loglevel"
          "warning"
          "--requirepass"
          "coolify"
        ];
        environment = { REDIS_PASSWORD = "coolify"; };
        volumes = [ "coolify_redis:/data" ];

        extraOptions = [
          "--health-cmd='redis-cli ping'"
          "--health-interval=30s"
          "--health-retries=3"
          "--health-timeout=20s"
          "--network=coolify"
        ];
      };
      soketi = {
        image = "ghcr.io/coollabsio/coolify-realtime:1.0.4";
        hostname = "coolify-soketi";
        ports = [ "6001:6001" "6002:6002" ];
        volumes = [ "/data/coolify/ssh:/var/www/html/storage/app/ssh" ];
        environment = {
          APP_NAME = "coolify";
          SOKETI_DEBUG = "false";
          SOKETI_DEFAULT_APP_ID =
            "b651633bf5766d96ef55fb7786eb96b306f76668afb670e71c375b4438a39286";
          SOKETI_DEFAULT_APP_KEY =
            "0a71429ad3f6500efefdc5eae3c3cad0b3359d28dac5a83cb7456b16168e93e4";
          SOKETI_DEFAULT_APP_SECRET =
            "ca8ac45c8e73862608fc5746de2080bf9746ea6f385e38e0dbdbfb8147ce103b";
        };

        extraOptions = [
          "--health-cmd='wget -qO- http://127.0.0.1:6001/ready && wget -qO- http://127.0.0.1:6002/ready || exit 1'"
          "--health-interval=30s"
          "--health-retries=3"
          "--health-timeout=20s"
          "--network=coolify"
          "--add-host=host.docker.internal:host-gateway"
        ];
      };
    };

    # Networks
    systemd.services."docker-network-coolify" = {
      path = [ pkgs.docker ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "${pkgs.docker}/bin/docker network rm -f coolify";
      };
      script = ''
        docker network inspect coolify || docker network create coolify
      '';
      partOf = [ "coolify.target" ];
      wantedBy = [ "coolify.target" ];
    };

    # Volumes
    systemd.services."docker-volume-coolify_data" = {
      path = [ pkgs.docker ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        docker volume inspect coolify_data || docker volume create coolify_data
      '';
      partOf = [ "coolify.target" ];
      wantedBy = [ "coolify.target" ];
    };

    systemd.services."docker-volume-coolify_redis" = {
      path = [ pkgs.docker ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        docker volume inspect coolify_redis || docker volume create coolify_redis
      '';
      partOf = [ "coolify.target" ];
      wantedBy = [ "coolify.target" ];
    };

    systemd.services."coolify-ssh" = {
      path = [ pkgs.openssh ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        mkdir -p /data/coolify/ssh/keys
        ls /data/coolify/ssh/keys/id.root@host.docker.internal || ssh-keygen -f "/data/coolify/ssh/keys/id.root@host.docker.internal" -t ed25519 -N "" -C root@coolify
        key=$(cat /data/coolify/ssh/keys/id.root@host.docker.internal.pub)
        mkdir -p /root/.ssh
        grep "$key" /data/coolify/ssh/authorized_keys || echo "$key" >> /root/.ssh/authorized_keys
        (rm /data/coolify/source/.env || true) && ln -s ${
          toString envFile
        } /data/coolify/source/.env
        chown coolify:coolify -R /data/coolify
      '';
      partOf = [ "coolify.target" ];
      wantedBy = [ "coolify.target" ];
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    systemd.targets."coolify" = {
      unitConfig = { Description = "Root coolify target"; };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
