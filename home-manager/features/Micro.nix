{
	pkgs,
	lib,
	config,
	...
}: {
	config = with config.colorScheme.colors; {
		home.file.".config/micro/colorschemes/nix-colorscheme.micro".text = ''
			color-link default "#${base05},#${base00}"
			color-link comment "#${base04}"
					
			color-link identifier "#${base00}"
			color-link identifier.class "#${base00}"
			color-link identifier.var "#${base00}"
				
			color-link constant "#${base09}"
			color-link constant.number "#${base09}"
			color-link constant.string "#${base0B}"
					
			color-link symbol "#${base0B}"
			color-link symbol.brackets "#${base0F}"
			color-link symbol.tag "#${base0D}"
					
			color-link type "#${base0D}"
			color-link type.keyword "#${base0A}"
					
			color-link special "#${base0B}"
			color-link statement "#${base0E}"
			color-link preproc "#${base0B}"
				
			color-link underlined "#${base0C}"
			color-link error "bold #${base08}"
			color-link todo "bold #${base0A}"
					
			color-link diff-added "#${base0B}"
			color-link diff-modified "#${base0A}"
			color-link diff-deleted "#${base08}"
					
			color-link gutter-error "#${base08}"
			color-link gutter-warning "#${base0A}"
					
			color-link statusline "#${base05},#${base01}"
			color-link tabbar "#${base05},#${base01}"
			color-link indent-char "#${base03}"
			color-link line-number "#${base03}"
			color-link current-line-number "#${base07}"
					
			color-link cursor-line "#${base02},#${base05}"
			color-link color-column "#${base02}"
			color-link type.extended "default"
		'';

		home.file.".config/micro/bindings.json".text = ''
			{
			    "Alt-/": "lua:comment.comment",
			    "CtrlUnderscore": "lua:comment.comment",
			    "Ctrl-Shift-Z": "Redo"
			}
		'';
						
		programs.micro = {
			enable = true;
			 
		 	settings = with config.colorScheme.colors; {
		 			colorscheme = "nix-colorscheme";
		 			tabsize = 2;
		 	};
		};
	};
}
