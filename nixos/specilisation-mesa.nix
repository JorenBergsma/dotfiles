({
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.specialisation != {}) {
    environment.systemPackages = with pkgs; [
      mesa
    ];
  };
})
