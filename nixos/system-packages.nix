 {
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gtk

    hackneyed
    gpu-screen-recorder
    remmina
    
    #Terminal
    kitty starship

    # File manager
    yazi fzf unar mpv exiftool mediainfo

    # Text editor
    micro

    wofi

    # Menu bar
    waybar

    # Notification system
    dunst libnotify

    # Wallpaper daemon
    swww

    # Disk manager
    diskonaut

    # Screenshot tools
    grim slurp wl-clipboard

    #Commandline
    wget
    git
    pciutils
    btop
    udisks
    jq
    fastfetch

    #Utility
    opentabletdriver
    vesktop discocss
    firefox

    #Games
    osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    r2modman
    stable.runelite

    #Creative
    godot_4
    blender
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CommitMono" ]; })
  ];

}
