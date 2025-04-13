{
  description = "My personal NixOS configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, stylix, sops-nix
    , nixos-wsl, ... }@inputs:
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
        devbox = nixpkgs.lib.nixosSystem {
          specialArgs = {
            hostname = "devbox";
            inherit inputs outputs lib;
          };
          modules = [
            ./hosts/vm/configuration.nix
            catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
          ];
        };
        pentestbox = nixpkgs.lib.nixosSystem {
          specialArgs = {
            hostname = "pentestbox";
            inherit inputs outputs lib;
          };
          modules = [
            ./hosts/vm/configuration.nix
            catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
          ];
        };
        nixos-desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs lib; };
          modules = [
            ./hosts/desktop/configuration.nix
            catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
          ];
        };
        nixvps = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs lib; };
          modules = [
            ./hosts/vps/configuration.nix
            catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
          ];
        };
        nixwsl = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs lib; };
          modules = [
            ./hosts/wsl/configuration.nix
            catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
            nixos-wsl.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        "deck@steamdeck" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs lib; };
          modules = [
            ./home/dreadster/steamdeck.nix
            stylix.homeManagerModules.stylix
            sops-nix.homeManagerModules.sops
            catppuccin.homeModules.catppuccin
          ];
        };
      };
    };
}
