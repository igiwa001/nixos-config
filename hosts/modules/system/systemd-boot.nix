{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot = {
    # Initrd bsod screen
    initrd.systemd.enable = true;

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
