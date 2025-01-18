{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
      editor = false;
    };
  };
}
