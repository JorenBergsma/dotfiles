{
  config,
  pkgs,
  ...
}: let
  nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in {
  environment.systemPackages = with pkgs; [
    #Games
    unstable.runelite
    unstable.osu-lazer-bin
    nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable
    unstable.r2modman

    #Creative
    unstable.godot_4
    unstable.blender
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
