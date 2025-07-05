{ inputs, ... }: {
  imports = [ ./common.nix inputs.stylix.homeModules.stylix ];
}
