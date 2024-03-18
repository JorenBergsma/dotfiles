{
	pkgs,
	inputs,
	config,
	...
}: {
	config =  {
		programs.firefox = {
			enable = true;
			profiles.gelei = {

				search.engines = {
					"Nix Packages" = {
				  	urls = [{
				    	template = "https://search.nixos.org/packages";
				      params = [
				        { name = "type"; value = "packages"; }
				        { name = "query"; value = "{searchTerms}"; }
				      ];
				    }];
				
				    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
				    definedAliases = [ "@np" ];
				  };
				};
				search.force = true;

				bookmarks = [
					{
				  name = "MyNixOS";
					url = "https://mynixos.com/";
				  }
				  {
				  name = "NixOS Search";
				  url = "https://search.nixos.org/packages";
				  }
					{
				  name = "Photopea";
				  url = "https://www.photopea.com/";
				  }
				];
			
				settings = with config.colorScheme.colors; {
					"browser.search.widget.inNavBar" = false;
					"services.sync.prefs.sync.browser.urlbar.showSearchSuggestionsFirst" = false;
					"browser.toolbars.bookmarks.visibility" = "never";

					# Colorscheme
					
				};

				extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
					bitwarden
					firefox-color
				];

				userChrome = ''
					${builtins.readFile(builtins.fetchurl {
						url = "https://raw.githubusercontent.com/Haruzona/penguinFox/main/files/chrome/userChrome.css";
						sha256 = "1jk9w9c3jfi03hswz007nn3ykgmq2dn2dib8a6ravw1vacr37j7g";
					})}
				'';

				userContent = ''
					${builtins.readFile(builtins.fetchurl {
						url = "https://raw.githubusercontent.com/Haruzona/penguinFox/main/files/chrome/userContent.css";
						sha256 = "0aay2llxbfxm3clrjii21rzqm7nmqc3hja1gr4z8ifn8vpcg8270";
					})}
				'';
			};
		};
	};
}
