{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
	colorScheme = inputs.nix-colors.colorSchemes.kanagawa;
	
	stylix = {
		image = ./wallpaper.png;

		base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
		
		fonts = {
			monospace = {
		    package = pkgs.nerdfonts;
		    name = "Commit Mono";
		  };
			serif = config.stylix.fonts.monospace;
			sansSerif = config.stylix.fonts.monospace;
			emoji = config.stylix.fonts.monospace;
		};
		
		cursor = {
			package = pkgs.hackneyed;
			name = "Hackneyed";
			size = 16;
		};

		targets = {
			firefox.enable = true;
			gtk.enable = true;
			kitty.enable = true;
			yazi.enable = true;
			hyprland.enable = true;
		};
	};
}
