{ ... }: {
  home-manager.users = { dreadster = import ../../home/dreadster/laptop.nix; };
}
