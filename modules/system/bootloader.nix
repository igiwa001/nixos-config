{
  lib,
  config,
  ...
}: let
  cfg = config.settings.bootloader;
in {
  options.settings.bootloader = {
    initrd = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    configurationLimit = lib.mkOption {
      type = lib.types.ints.positive;
      default = 3;
    };

    plymouth = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config.boot = {
    initrd = lib.mkIf cfg.initrd {
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
        inherit (cfg) configurationLimit;
      };
    };

    plymouth.enable = cfg.plymouth;
    kernelParams = lib.optional cfg.plymouth "quiet";
  };
}
