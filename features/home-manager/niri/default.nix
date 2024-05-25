{ pkgs, inputs, ... }: {
  imports = [
    inputs.niri.homeModules.niri
    ./niri.nix
    ./waybar.nix
    ./i3.nix
  ];
  home.packages = with pkgs; [
    xwayland
    wl-clipboard # copy to clipboard
    wayland-satellite
  ];
  stylix.targets = { gtk.enable = true; };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
