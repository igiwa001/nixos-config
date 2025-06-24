{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.hardware;
in {
  options.settings.hardware.wooting = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf cfg.wooting {
    hardware.wooting.enable = true;
    environment.systemPackages = [pkgs.wooting-udev-rules];
  };
}
