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

    loader = lib.mkOption {
      type = lib.types.enum ["grub" "systemd" "generic"];
      default = "systemd";
    };

    grub.device = lib.mkOption {
      type = lib.types.str;
      default = "nodev";
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
        enable = cfg.loader == "systemd";
        editor = false;
        inherit (cfg) configurationLimit;
      };
      grub = {
        enable = cfg.loader == "grub";
        inherit (cfg.grub) device;
        inherit (cfg) configurationLimit;
      };
      generic-extlinux-compatible = {
        enable = cfg.loader == "generic";
        inherit (cfg) configurationLimit;
      };
    };

    plymouth.enable = cfg.plymouth;
    kernelParams = lib.optional cfg.plymouth "quiet";
  };
}
