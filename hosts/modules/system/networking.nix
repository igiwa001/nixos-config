{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  networking = {
    networkmanager.enable = true;
    wireless.iwd.enable = true;
  };
}
