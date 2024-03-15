 {
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    #Commandline
    wget
    pipx
    diskonaut
    pciutils
    git

    #Utility
    opentabletdriver
    vesktop
    kdePackages.filelight
    firefox
    kate

    #Games
    steam
    osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    r2modman
    stable.runelite

    #Creative
    godot_4
    blender
  ];
}
