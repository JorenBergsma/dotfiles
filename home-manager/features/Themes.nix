{ 
	inputs, 
	pkgs, ...
}: {
	imports = [
		inputs.nix-colors.homeManagerModules.default
	];
	colorScheme = inputs.nix-colors.colorSchemes.kanagawa;
}
