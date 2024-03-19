{ pkgs, ... }:
{
  home.packages = [ pkgs.fastfetch ];
  xdg.configFile."fastfetch/config.jsonc".text = /* json */ ''
	{
    "modules": [
        "title",
        "separator",
        {
            "type": "os",
            "key": " OS",
            "keyColor": "yellow",
            "format": "{2}"
        },
        {
            "type": "os",
            "key": "├", // Just get your distro's logo off nerdfonts.com
            "keyColor": "yellow",
            "format": "{6}{?6} {?}{10} {8}"
        },
				/*
        {
            "type": "kernel",
            "key": "├",
            "keyColor": "yellow"
        },
        {
            "type": "packages",
            "key": "├󰏖",
            "keyColor": "yellow"
        },
				*/
        {
            "type": "shell",
            "key": "└",
            "keyColor": "yellow"
        },
        "break",

        {
            "type": "wm",
            "key": " DE/WM",
            "keyColor": "blue"
        },
				/*
        {
            "type": "lm",
            "key": "├󰧨",
            "keyColor": "blue"
        },
				*/
        {
            "type": "wmtheme",
            "key": "├󰉼",
            "keyColor": "blue"
        },
        {
            "type": "icons",
            "key": "├󰀻",
            "keyColor": "blue"
        },
        {
            "type": "terminal",
            "key": "└",
            "keyColor": "blue"
        },
				/*
        {
            "type": "wallpaper",
            "key": "└󰸉",
            "keyColor": "blue"
        },
				*/

        "break",
        {
            "type": "host",
            "key": "󰌢 PC",
            "keyColor": "green"
        },
        {
            "type": "cpu",
            "key": "├",
            "keyColor": "green"
        },
        {
            "type": "gpu",
            "key": "├󰘚",
            "keyColor": "green"
        },
        {
            "type": "disk",
            "key": "├",
            "keyColor": "green"
        },
        {
            "type": "memory",
            "key": "└󰑭",
            "keyColor": "green"
        },
				/*
        {
            "type": "swap",
            "key": "├󰓡",
            "keyColor": "green"
        },
        {
            "type": "uptime",
            "key": "├󰅐",
            "keyColor": "green"
        },
        {
            "type": "display",
            "key": "└󰍹",
            "keyColor": "green"
        },
        "break",
        {
            "type": "sound",
            "key": " SOUND",
            "keyColor": "cyan"
        },
        {
            "type": "player",
            "key": "├󰥠",
            "keyColor": "cyan"
        },
        {
            "type": "media",
            "key": "└󰝚",
            "keyColor": "cyan"
        },
				*/

        "break",
        "colors"
    ]
}
	'';
}
