{
  lib,
  config,
  ...
}: {
  options.bluetooth = {
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
      enable = config.bluetooth.enable;
      powerOnBoot = config.bluetooth.powerOnBoot;
    };
    services.blueman.enable = config.bluetooth.enable;
  };
}
