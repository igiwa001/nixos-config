{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot = {
    initrd = {
      systemd = {
        enable = true;
        dbus.enable = true;
      };
    };

    # Systemd bootloader
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        editor = false;
      };
    };
  };
}
