{ pkgs, outputs, ... }: {
  imports = [ outputs.homeManagerModules.sunbeam ./sunbeam.nix ];
  home.packages = with pkgs; [ deno nix-search-cli stable.j4-dmenu-desktop pulseaudio ];
}
