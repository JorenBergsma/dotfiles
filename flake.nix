{
  description = "Damnjelly's NixOS flake";

  inputs = {
    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    # Home manager
    home-manager = {
    	url = "github:nix-community/home-manager";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
    
		# Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Nix-gaming
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Firefox addons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ---Tinted theming---
    # Nix-colors
    nix-colors.url = "github:misterio77/nix-colors";
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    nix-colors,
    ...
  } @ inputs: 
	let
	  inherit (self) outputs;
	in {
	    # Your custom packages and modifications, exported as overlays
	    overlays = import ./overlays {inherit inputs;};

	    # NixOS configuration entrypoint
	    # Available through 'nixos-rebuild --flake .#nixos'
	    nixosConfigurations = {
	      nixos = nixpkgs.lib.nixosSystem {
	        specialArgs = {inherit inputs outputs;};

	        # > Our main nixos configuration file <
	        modules = [./nixos/configuration.nix];
	      };
	    };

	    # Standalone home-manager configuration entrypoint
	    # Available through 'home-manager --flake .#gelei@nixos'
	    homeConfigurations = {
	      "gelei@nixos" = home-manager.lib.homeManagerConfiguration {
	        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
	        extraSpecialArgs = {inherit inputs outputs;};

	        # > Our main home-manager configuration file <
	        modules = [
	        	stylix.homeManagerModules.stylix
  	      	nix-colors.homeManagerModules.default
		    	./home-manager/home.nix
        ];
      };
    };
  };
}
