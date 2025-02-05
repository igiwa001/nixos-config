{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      useOSProber = true;
      configurationLimit = 3;
    };
  };
}
