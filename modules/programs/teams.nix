{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.teams;
in {
  options.settings.programs.teams.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.home.packages = lib.mkIf cfg.enable [
    pkgs.teams-for-linux
  ];
}
