{
  lib,
  config,
  ...
}: {
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
      enable = config.settings.bluetooth.enable;
      powerOnBoot = config.settings.bluetooth.powerOnBoot;
    };
    services.blueman.enable = config.settings.bluetooth.enable;
  };
}
