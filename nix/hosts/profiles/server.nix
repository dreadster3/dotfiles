{ inputs, outputs, config, lib, pkgs, ... }:
let
in {
  imports = [ ./common.nix ];

  users.users.dreadster.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP29pHHpOPwY4wgvyuhx4n2Qu/md6KL78uvXBA+5cSAt dreadster@WSL"
  ];
  security.sudo.wheelNeedsPassword = false;
}
