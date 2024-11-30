{ inputs, outputs, config, lib, pkgs, ... }:
let
in {
  imports = [ ./common.nix ];

  modules.nixos = { fail2ban.enable = true; };

  users.users.dreadster.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP29pHHpOPwY4wgvyuhx4n2Qu/md6KL78uvXBA+5cSAt dreadster@WSL"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCE4y4iP00784oPIFjy8Ad+eWIRW1QPW74jXA/jQVltU8AI8XRKGCUduK8TLopbqZplKfZVgiKqOuMvvYhkQzvS4D1qawPrdamQ+bvTnI4ehZAU7K3lzKTWm2AABytiv9Xm1hF4/wqD/iPxz18rj+mHeoEjcAsNDT/7mPR3EAS0yOg784jfgmKVLyZZGZIcTgaW+SrVkJ68KKA2xlWNTHbALw0NuR1liMDPnEmOXJ0caplBZPH2rbABnR5A7q35FyJbt/3kzjT8T7LXUX51X40/4E20JS8fFvbEZq6EfFmgs8+HsGm3ZH/u6umNt9w3StHCc3c/i0IUodd2tpRjEeD root@pve30"
  ];
  security.sudo.wheelNeedsPassword = false;
}
