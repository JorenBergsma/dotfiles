 {
  config,
  pkgs,
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
  ];
}
