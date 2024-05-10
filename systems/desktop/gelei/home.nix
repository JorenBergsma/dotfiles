{ lib, inputs, config, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ./../../global-home.nix
    ./../../../users/gelei.nix

    ./../../../features/home-manager/cli
    ./../../../features/home-manager/creative
    ./../../../features/home-manager/discord/vesktop.nix
    ./../../../features/home-manager/firefox/firefox.nix
    ./../../../features/home-manager/games
    ./../../../features/home-manager/niri
    ./../../../features/home-manager/nixvim
    ./../../../features/home-manager/shell
    ./../../../features/home-manager/sunbeam
    ./../../../features/home-manager/work
  ];
  config = {
    theme = "madotsuki";

    programs.wpaperd = {
      enable = true;
      settings = {
        DP-1.path = "/home/${config.home.username}/.config/wpaperd/wallpapers/";
        DP-2.path = "/home/${config.home.username}/.config/wpaperd/wallpapers/";
        HDMI-A-1.path = "/home/${config.home.username}/.config/wpaperd/wallpapers/";
      };
    };
    home.persistence."/persist/home/${config.home.username}" = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
      ];
      allowOther = true;
    };
    home.stateVersion = lib.mkDefault "23.11";
  };
}
