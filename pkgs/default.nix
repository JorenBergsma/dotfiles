# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs ? import <nixpkgs> { } }: rec {
  kirsch = pkgs.callPackage ./kirsch { };
  sunbeam = pkgs.callPackage ./sunbeam { };
  retro = pkgs.callPackage ./retro { };
  xwayland-satellite = pkgs.callPackage ./xwayland_satellite { };
  #j4-dmenu-desktop = pkgs.callPackage ./j4-dmenu-desktop { };
}
