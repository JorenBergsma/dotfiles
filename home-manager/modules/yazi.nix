{
	pkgs,
	config,
	...
}: {
	# Smart enter: enter for directory, open for file
	config = {
		home.file.".config/yazi/plugins/smart-enter.yazi/init.lua".text = ''
				return {
					entry = function()
						local h = cx.active.current.hovered
						ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
					end,
				}
			'';
		home.file.".config/yazi/init.lua".text = ''
			Manager = {
				area = ui.Rect.default,
			}
			
			function Manager:layout(area)
				self.area = area
			
				return ui.Layout()
					:direction(ui.Layout.HORIZONTAL)
					:constraints({
						ui.Constraint.Ratio(MANAGER.ratio.parent, MANAGER.ratio.all),
						ui.Constraint.Ratio(MANAGER.ratio.current, MANAGER.ratio.all),
						ui.Constraint.Ratio(MANAGER.ratio.preview, MANAGER.ratio.all),
					})
					:split(area)
			end
			
			function Manager:render(area)
				local chunks = self:layout(area)

				local bar = function(c, x, y)
					x, y = math.max(0, x), math.max(0, y)
					return ui.Bar(ui.Rect { x = x, y = y, w = ya.clamp(0, area.w - x, 1), h = math.min(1, area.h) }, ui.Bar.TOP)
						:symbol(c)
				end
			
				return ya.flat {
					-- Borders
					ui.Border(area, ui.Border.ALL):type(ui.Border.ROUNDED),
						ui.Bar(chunks[1], ui.Bar.RIGHT),
						ui.Bar(chunks[3], ui.Bar.LEFT),
					
						bar("┬", chunks[1].right - 1, chunks[1].y),
						bar("┴", chunks[1].right - 1, chunks[1].bottom - 1),
						bar("┬", chunks[2].right, chunks[2].y),
						bar("┴", chunks[2].right, chunks[1].bottom - 1),
								
					-- Parent
					Parent:render(chunks[1]:padding(ui.Padding.xy(1))),
					-- Current
					Current:render(chunks[2]:padding(ui.Padding.y(1))),
					-- Preview
					Preview:render(chunks[3]:padding(ui.Padding.xy(1))),
				}
			end
			'';			
			
		programs.yazi = {
			enable = true;
			enableBashIntegration = true;
	
			keymap = {
				manager = {
					prepend_keymap = [
						{
							exec 	= "plugin --sync smart-enter";
							on 		= [ "<Enter>" ];
							desc 	= "Enter the child directory, or open the file";
						}
					];
				};
			};
	
			settings = {
				headsup.disable_exec_warn = true;
				manager = {
					ratio		= [ 1 4 3 ];
					sort_by = "extension";
				};
				
				preview = {
					tab_size        = 2;
					max_width       = 600;
					max_height      = 900;
					cache_dir       = "";
					image_filter    = "triangle";
					image_quality   = 75;
					sixel_fraction  = 15;
					ueberzug_scale  = 2;
					ueberzug_offset = [ 0 0 0 0 ];
				};
	
				opener = {
					edit = [
						{ 
							exec = "micro \"$@\"";
							desc = "micro";
							block = true;
							for = "unix";
						}
					];
					open = [
						{
							exec = "xdg-open \"$@\"";
							desc = "Open";
							for = "linux";
						}
					];
					reveal = [
						{
							exec = "exiftool \"$1\"; echo \"Press enter to exit\"; read _";
							block = true;
							desc = "Show EXIF";
							for = "unix";
						}
					];
					extract = [
						{
							exec = "unar \"$1\"";
							desc = "Extract here"; 
							for = "unix";
						}
					];
					play = [
						{
							exec = "mpv \"$@\"";
							orphan = true; 
							for = "unix";
						} 
						{ 
							exec = "mediainfo \"$1\"; echo \"Press enter to exit\"; read _";
							block = true;
							desc = "Show media info";
							for = "unix";
						}
					];
				};
	
				open = {
					rules = [
						{ 
							name = "*/"; 
							use = [ "edit" "open" "reveal" ]; 
						}
						{ 
							mime = "text/*";  
							use = [ "edit" "reveal" ];
						}
						{ 
							mime = "image/*";
							use = [ "open" "reveal" ];
						}
						{ 
							mime = "video/*";
							use = [ "play" "reveal" ];
						}
						{ 
							mime = "audio/*";
							use = [ "play" "reveal" ];
						}
						{
							mime = "inode/x-empty";
							use = [ "edit" "reveal" ];
						}
						{ 
							mime = "application/json";
							use = [ "edit" "reveal" ];
						}
						{ 
							mime = "*/javascript";    
							use = [ "edit" "reveal" ];
						}
						
						# Archives
						{ 
							mime = "application/zip";           
							use = [ "extract" "reveal" ];
						}
						{ 
							mime = "application/gzip";           
							use = [ "extract" "reveal" ];
						}
						{ 
							mime = "application/x-tar";        	  
							use = [ "extract" "reveal" ];
						}
						{ 
							mime = "application/x-bzip";          
							use = [ "extract" "reveal" ];
						}
						{ 
							mime = "application/x-bzip2";        
							use = [ "extract" "reveal" ];
						}
						{ 
							mime = "application/x-7z-compressed";
							use = [ "extract" "reveal" ];
						}
						{ 
							mime = "application/x-rar";          
							use = [ "extract" "reveal" ];
						}
						{ 
							mime = "application/xz";           
							use = [ "extract" "reveal" ];
						}
						# Other
						{ 
							mime = "*"; 
							use = [ "open" "reveal" ];
						}
					];
				};
			};
		};
	};
}
