{
  lib,
  config,
  ...
}: {
  options.bootloader = {
    initrd = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    configurationLimit = lib.mkOption {
      type = lib.types.positive;
      default = 3;
    };
  };

  config.boot = {
    initrd = lib.mkIf config.bootloader.initrd {
      systemd = {
        enable = true;
        dbus.enable = true;
      };
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = config.bootloader.configurationLimit;
      };
    };
  };
}
