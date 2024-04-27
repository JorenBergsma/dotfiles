{ pkgs, config, ... }:
let
  customtheme = pkgs.writeTextFile {
    name = "theme.yaml";
    text = "${builtins.readFile ./madotsuki.yaml}";
    destination = "/theme/theme.yaml";
  };
in {
  stylix = {
    image = ./wallpaper.png;
    base16Scheme = "${customtheme}/theme/theme.yaml";
    # To choose a theme, edit the text above ^ to any of https://github.com/tinted-theming/base16-schemes

    fonts = {
      monospace = {
        package = pkgs.hack-font;
        name = "Hack";
      };

      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
      sizes = { terminal = 14; };
    };

    cursor = {
      package = pkgs.hackneyed;
      name = "Hackneyed";
      size = 16;
    };
  };
}
