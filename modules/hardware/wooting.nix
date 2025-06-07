{
  lib,
  config,
  pkgs,
  ...
}: {
  options.settings.hardware = {
    wooting = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.settings.hardware.wooting {
    hardware.wooting.enable = true;
    environment.systemPackages = [pkgs.wooting-udev-rules];
  };
}
