{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.slack;
in {
  options.settings.programs.slack.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.home.packages = lib.mkIf cfg.enable [
    pkgs.slack
  ];
}
