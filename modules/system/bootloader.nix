{
  lib,
  lib',
  ...
}: let
  description = ''
    Enables and configures the bootloader.
    Defaults to systemd-boot, but can be overridden.
    Additionally enables initrd, plymouth and sets some common bootloader settings.

    Usage:
      den.aspects.example.includes = [den.aspects.bootloader];
      den.aspects.example.includes = [(den.aspects.bootloader.override { bootloader = "grub"; })];
  '';

  bootloader-enable = lib'.makeOverridableAspectWith ({bootloader ? "systemd-boot", ...}: {
    name = "bootloader/enable";
    description = ''
      Enables the specified bootloader.
    '';

    nixos.boot.loader.${bootloader}.enable = true;
  });

  bootloader-config = lib'.makeOverridableAspectWith ({
    configurationLimit ? 3,
    device ? "nodev", # Only applies to grub
    ...
  }: {
    name = "bootloader/config";
    description = ''
      Configures the bootloader.
    '';

    nixos.boot.loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        inherit configurationLimit;
        editor = false;
      };

      grub = {
        inherit configurationLimit device;
        enable = lib.mkDefault false;
      };

      generic-extlinux-compatible = {
        inherit configurationLimit;
      };
    };
  });

  initrd = {
    name = "bootloader/initrd";
    description = ''
      Enables initrd.
    '';

    nixos.boot.initrd = {
      enable = true;
      systemd = {
        enable = true;
        dbus.enable = true;
      };
    };
  };

  plymouth = {
    name = "bootloader/plymouth";
    description = ''
      Enables plymouth.
    '';

    nixos.boot = {
      plymouth.enable = true;
      kernelParams = ["quiet"];
    };
  };
in {
  den.aspects.system.bootloader = lib'.makeOverridableAspect (params: {
    name = "bootloader";
    inherit description;
    includes = [
      (bootloader-enable params)
      (bootloader-config params)
      initrd
      plymouth
    ];
  });
}
