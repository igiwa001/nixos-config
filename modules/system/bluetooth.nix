{
  lib,
  config,
  ...
}: let
  cfg = config.settings.bluetooth;
in {
  options.settings.bluetooth = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    powerOnBoot = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    hardware.bluetooth = {
      enable = cfg.enable;
      powerOnBoot = cfg.powerOnBoot;
    };
    services.blueman.enable = cfg.enable;
  };
}
