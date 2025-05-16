{ pkgs, ... }: {
  users.groups.coolify = { gid = 9999; };
  users.users.coolify = {
    shell = pkgs.bash;
    isSystemUser = true;
    hashedPassword = "!";
    group = "coolify";
    uid = 9999;
    extraGroups = [ "docker" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmhF9FcxJi8EOkb+Fc4Kv3SEw5hhU7L1+9izoLyCmdV coolify@nixvps"
    ];
  };
}
