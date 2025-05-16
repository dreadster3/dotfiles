{ ... }: {
  imports = [ ../users.nix ];

  home-manager.users.dreadster = {
    imports = [ ../../profiles/homemanager/server.nix ];

    home.stateVersion = "23.11";
  };
}
