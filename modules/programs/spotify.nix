{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.spotify;
in {
  options.settings.programs.spotify.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.home.packages = lib.mkIf cfg.enable [
    pkgs.spotify
  ];
}
