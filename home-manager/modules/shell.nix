{
	pkgs,
	lib,
	...
}: {
	programs.bash = {
		enable = true;
		shellAliases = {			
			home-rebuild = "home-manager switch --flake ~/Documents/nix-config/#gelei@nixos";
			hr					 = "home-manager switch --flake ~/Documents/nix-config/#gelei@nixos";
			
			flake-rebuild = "sudo nixos-rebuild switch --flake ~/Documents/nix-config/#nixos";
			fr 						= "sudo nixos-rebuild switch --flake ~/Documents/nix-config/#nixos";

			genenerations-list = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
			gl			 					 = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

			genenerations-delete = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
			gd				 					 = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
		};

		bashrcExtra = ''
			export "MICRO_TRUECOLOR=1"
		'';
	};
  programs.starship = {
    enable = true;
    settings = {
      username = {
        style_user = "blue bold";
        style_root = "red bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "🌐 ";
        format = "on [$hostname](bold red) ";
        trim_at = ".local";
        disabled = false;
      };
    };
  };
}
