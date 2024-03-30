{
  description = "My personal NixOS configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        nixosvm = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs-unstable;
            inherit pkgs;
          };
          modules = [
            ./hosts/nixosvm/configuration.nix

            ./users/dreadster/base.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit pkgs-unstable; };

              home-manager.users.dreadster = {
                imports = [ ./users/dreadster/home/vm.nix ];
              };
            }
          ];
        };
        nixos-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./hosts/desktop/configuration.nix

            ./users/dreadster/base.nix

            home-manager.nixosModules.home-manager
            {
              # Needs to be disabled for spicetify overlay to work
              # home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit pkgs-unstable; };

              home-manager.users.dreadster = {
                imports = [ ./users/dreadster/home/desktop.nix ];
              };
            }
          ];
        };
      };
    };
}
