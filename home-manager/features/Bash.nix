{
	pkgs,
	lib,
	...
}: {
	programs.bash = {
		enable = true;
		shellAliases = {
			discord = "vesktop";
			
			home-rebuild = "home-manager switch --flake ~/Documents/nix-config/#gelei@nixos";
			hr					 = "home-manager switch --flake ~/Documents/nix-config/#gelei@nixos";
			
			flake-rebuild = "sudo nixos-rebuild switch --flake ~/Documents/nix-config/nixos";
			fr 						= "sudo nixos-rebuild switch --flake ~/Documents/nix-config/nixos";
		};

		bashrcExtra = ''
			export "MICRO_TRUECOLOR=1"
		'';
	};
}
