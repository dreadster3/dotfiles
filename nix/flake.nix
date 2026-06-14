{
  description = "My personal NixOS configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tssp = {
      url = "github:nukdokplex/tssp-nix/ea999343fe2885ac9c815439446d2f4279c38560";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      stylix,
      sops-nix,
      tssp,
      ...
    }@inputs:
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

      lib = nixpkgs.lib.extend (_: prev: (import ./lib { lib = prev; }) // home-manager.lib);

    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      overlays = import ./overlays { inherit inputs; };

      nixosModules = (import ./modules/nixos) { };
      homeManagerModules = (import ./modules/homemanager) { };

      nixosConfigurations = {
        nixos-desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs lib; };
          modules = [
            ./hosts/desktop/configuration.nix
            catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
            tssp.nixosModules.default
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
      };

      homeConfigurations = {
        "deck@steamdeck" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs lib; };
          modules = [
            ./hosts/steamdeck/deck.nix
            stylix.homeModules.stylix
            sops-nix.homeManagerModules.sops
            catppuccin.homeModules.catppuccin
          ];
        };
      };
    };
}
