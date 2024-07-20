{
  description = "My personal NixOS configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      inherit (self) outputs;

      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      lib = nixpkgs.lib.extend
        (final: prev: (import ./lib { lib = prev; }) // home-manager.lib);
    in {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      overlays = import ./overlays { inherit inputs; };

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/homemanager;

      nixosConfigurations = {
        nixosvm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs lib; };
          modules = [ ./hosts/nixosvm/configuration.nix ];
        };
        nixos-desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs lib; };
          modules = [ ./hosts/desktop/configuration.nix ];
        };
        nixos-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs lib; };
          modules = [ ./hosts/laptop/configuration.nix ];
        };
      };

      homeConfigurations = {
        "dreadster@wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs lib; };
          modules = [ ./home/dreadster/homewsl.nix ];
        };
        "deck@steamdeck" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/dreadster/steamdeck.nix ];
        };
      };
    };
}
