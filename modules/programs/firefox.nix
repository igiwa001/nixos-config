{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs.firefox;
in {
  options.settings.programs.firefox.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.home.packages = lib.mkIf cfg.enable [
    pkgs.firefox
  ];
}
