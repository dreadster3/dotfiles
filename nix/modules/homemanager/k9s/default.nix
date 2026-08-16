{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.homemanager.k9s;
in
{
  options = {
    modules.homemanager.k9s = {
      enable = mkEnableOption "k9s";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kubectl
      cmctl
      # krr NOTE: nixpkg unmaintained
      fluxcd
      fluxcd-operator
      jq
      less
    ];

    programs.k9s = {
      enable = true;
      plugins = {
        krr = {
          shortCut = "Shift-K";
          description = "Get krr";
          scopes = [
            "deployments"
            "daemonsets"
            "statefulsets"
            "cronjobs"
          ];
          command = "bash";
          background = false;
          confirm = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/krr.sh)
          ];
        };
        cert-status = {
          shortCut = "Shift-C";
          confirm = false;
          description = "Certificate status";
          scopes = [ "certificates" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            "cmctl status certificate --context $CONTEXT -n $NAMESPACE $NAME |& less"
          ];
        };
        cert-renew = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Certificate renew";
          scopes = [ "certificates" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            "cmctl renew --context $CONTEXT -n $NAMESPACE $NAME |& less"
          ];
        };
        secret-inspect = {
          shortCut = "Shift-I";
          confirm = false;
          description = "Inspect secret";
          scopes = [ "secrets" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            "cmctl inspect secret --context $CONTEXT -n $NAMESPACE $NAME |& less"
          ];
        };
        debug = {
          shortCut = "Shift-D";
          description = "Add debug container";
          dangerous = true;
          scopes = [ "containers" ];
          command = "bash";
          background = false;
          confirm = true;
          inputs = [
            {
              name = "image";
              label = "Debug image";
              type = "dropdown";
              required = true;
              default = "nicolaka/netshoot:v0.15";
              options = [
                "nicolaka/netshoot:v0.15"
                "busybox:1.37"
                "alpine:3.23"
                "ubuntu:26.04"
              ];
            }
            {
              name = "profile";
              label = "Debug profile";
              type = "dropdown";
              required = true;
              default = "sysadmin";
              options = [
                "general"
                "baseline"
                "restricted"
                "netadmin"
                "sysadmin"
                "legacy"
              ];
            }
            {
              name = "share_processes";
              label = "Share processes";
              type = "bool";
              required = true;
              default = true;
            }
          ];
          args = [
            "-c"
            (builtins.readFile ./scripts/debug.sh)
          ];
        };
        toggle-helmrelease = {
          shortCut = "Shift-T";
          confirm = true;
          scopes = [ "helmreleases" ];
          description = "Toggle to suspend or resume a HelmRelease";
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/toggle-helmrelease.sh)
          ];
        };
        toggle-kustomization = {
          shortCut = "Shift-T";
          confirm = true;
          scopes = [ "kustomizations" ];
          description = "Toggle to suspend or resume a Kustomization";
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/toggle-kustomization.sh)
          ];
        };
        reconcile-git = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Flux reconcile";
          scopes = [ "gitrepositories" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-git.sh)
          ];
        };
        reconcile-hr = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Flux reconcile";
          scopes = [ "helmreleases" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-hr.sh)
          ];
        };
        reconcile-helm-repo = {
          shortCut = "Shift-Z";
          description = "Flux reconcile";
          scopes = [ "helmrepositories" ];
          command = "bash";
          background = false;
          confirm = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-helm-repo.sh)
          ];
        };
        reconcile-oci-repo = {
          shortCut = "Shift-Z";
          description = "Flux reconcile";
          scopes = [ "ocirepositories" ];
          command = "bash";
          background = false;
          confirm = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-oci-repo.sh)
          ];
        };
        reconcile-ks = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Flux reconcile";
          scopes = [ "kustomizations" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-ks.sh)
          ];
        };
        reconcile-ir = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Flux reconcile";
          scopes = [ "imagerepositories" ];
          command = "sh";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-ir.sh)
          ];
        };
        reconcile-iua = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Flux reconcile";
          scopes = [ "imageupdateautomations" ];
          command = "sh";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-iua.sh)
          ];
        };
        toggle-rset = {
          shortCut = "Shift-T";
          confirm = false;
          scopes = [ "resourcesets" ];
          description = "Toggle to suspend or resume a ResourceSet";
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/toggle-rset.sh)
          ];
        };
        toggle-inputprovider = {
          shortCut = "Shift-T";
          confirm = false;
          scopes = [ "resourcesetinputprovider" ];
          description = "Toggle to suspend or resume an InputProvider";
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/toggle-inputprovider.sh)
          ];
        };
        reconcile-rset = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Flux reconcile";
          scopes = [ "resourcesets" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-rset.sh)
          ];
        };
        reconcile-inputprovider = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Flux reconcile";
          scopes = [ "resources" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-inputprovider.sh)
          ];
        };
        reconcile-fluxinstance = {
          shortCut = "Shift-R";
          confirm = false;
          description = "Flux reconcile";
          scopes = [ "fluxinstances" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/reconcile-fluxinstance.sh)
          ];
        };
        toggle-fluxinstance = {
          shortCut = "Shift-T";
          confirm = false;
          scopes = [ "fluxinstances" ];
          description = "Toggle to suspend or resume a FluxInstance";
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/toggle-fluxinstance.sh)
          ];
        };
        trace = {
          shortCut = "Shift-Q";
          confirm = false;
          description = "Flux trace";
          scopes = [ "all" ];
          command = "bash";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/trace.sh)
          ];
        };
        get-suspended-helmreleases = {
          shortCut = "Shift-U";
          confirm = false;
          description = "Suspended Helm Releases";
          scopes = [ "helmrelease" ];
          command = "sh";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/get-suspended-helmreleases.sh)
          ];
        };
        get-suspended-kustomizations = {
          shortCut = "Shift-W";
          confirm = false;
          description = "Suspended Kustomizations";
          scopes = [ "kustomizations" ];
          command = "sh";
          background = false;
          args = [
            "-c"
            (builtins.readFile ./scripts/get-suspended-kustomizations.sh)
          ];
        };
        refresh-external-secrets = {
          shortCut = "Shift-R";
          confirm = false;
          scopes = [ "externalsecrets" ];
          description = "Refresh the externalsecret";
          command = "bash";
          background = true;
          args = [
            "-c"
            "kubectl annotate externalsecrets.external-secrets.io --context $CONTEXT -n $NAMESPACE $NAME force-sync=$(date +%s) --overwrite"
          ];
        };
        refresh-push-secrets = {
          shortCut = "Shift-R";
          confirm = false;
          scopes = [ "pushsecrets" ];
          description = "Refresh the pushsecret";
          command = "bash";
          background = true;
          args = [
            "-c"
            "kubectl annotate pushsecrets.external-secrets.io --context $CONTEXT -n $NAMESPACE $NAME force-sync=$(date +%s) --overwrite"
          ];
        };
      };
    };
  };
}
