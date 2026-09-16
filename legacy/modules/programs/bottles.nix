{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.settings.programs.bottles;
in {
  options.settings.programs.bottles.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.settings.home-manager.home.packages =
    lib.optional cfg.enable
    (pkgs.bottles.override {
      removeWarningPopup = true;
    });
}
