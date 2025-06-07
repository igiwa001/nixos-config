{
  lib,
  config,
  ...
}: {
  options.settings.bootloader = {
    initrd = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    configurationLimit = lib.mkOption {
      type = lib.types.ints.positive;
      default = 3;
    };
  };

  config.boot = {
    initrd = lib.mkIf config.settings.bootloader.initrd {
      enable = true;
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
        configurationLimit = config.settings.bootloader.configurationLimit;
      };
    };
  };
}
