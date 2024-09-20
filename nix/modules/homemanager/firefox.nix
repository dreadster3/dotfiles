{ pkgs, name, config, lib, ... }:
with lib;
let
  cfg = config.modules.homemanager.firefox;
  profilePath = profileName: ".mozilla/firefox/${profileName}";

  containers = {
    personal = {
      icon = "chill";
      color = "blue";
    };
    work = {
      icon = "briefcase";
      color = "green";
    };
    anonymous = {
      icon = "fingerprint";
      color = "purple";
    };
  };

  mkContainersJson = containers:
    let
      containersList = mapAttrsToList (name: container: {
        name = name;
        icon = container.icon;
        color = container.color;
      }) containers;

      identities = imap1 (idx: container: {
        userContextId = idx;
        name = container.name;
        icon = container.icon;
        color = container.color;
        public = true;
      }) containersList;
    in ''
      ${builtins.toJSON {
        version = 5;
        lastUserContextId = (last identities).userContextId;
        identities = identities ++ [
          {
            userContextId = 4294967294; # 2^32 - 2
            name = "userContextIdInternal.thumbnail";
            icon = "";
            color = "";
            accessKey = "";
            public = false;
          }
          {
            userContextId = 4294967295; # 2^32 - 1
            name = "userContextIdInternal.webextStorageLocal";
            icon = "";
            color = "";
            accessKey = "";
            public = false;
          }
        ];
      }}
    '';
in {
  options = {
    modules.homemanager.firefox = {
      enable = mkEnableOption "firefox";
      package = mkOption {
        type = types.package;
        default = pkgs.firefox-devedition;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = cfg.package;
      policies = {
        PromptForDownloadLocation = true;
        DefaultDownloadDirectory = config.home.homeDirectory + "/Downloads";
        Extensions = {
          Install = [
            "https://addons.mozilla.org/firefox/downloads/file/4317971/darkreader-4.9.88.xpi"
            "https://addons.mozilla.org/firefox/downloads/file/4316758/adguard_adblocker-4.3.64.xpi"
            "https://addons.mozilla.org/firefox/downloads/file/4307738/bitwarden_password_manager-2024.6.3.xpi"
            "https://addons.mozilla.org/firefox/downloads/file/4186050/multi_account_containers-8.1.3.xpi"
          ];
        };
      };
      profiles."${name}" = {
        id = 0;
        isDefault = true;
        settings = { "browser.search.region" = "PT"; };
        search = {
          default = "DuckDuckGo";
          force = true;
          privateDefault = "DuckDuckGo";
        };
      };
    };

    # home.file = {
    #   "${profilePath name}/containers.json" = {
    #     text = mkContainersJson containers;
    #     force = true;
    #   };
    # };
  };
}
