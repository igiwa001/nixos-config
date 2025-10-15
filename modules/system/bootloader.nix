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
      type = lib.types.enum ["grub" "systemd"];
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
      systemd-boot = lib.mkIf (cfg.loader == "systemd") {
        enable = true;
        editor = false;
        inherit (cfg) configurationLimit;
      };
      grub = lib.mkIf (cfg.loader == "grub") {
        enable = true;
        inherit (cfg.grub) device;
        inherit (cfg) configurationLimit;
      };
    };

    plymouth.enable = cfg.plymouth;
    kernelParams = lib.optional cfg.plymouth "quiet";
  };
}
