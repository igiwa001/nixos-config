{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  hardware.wooting.enable = true;
  environment.systemPackages = [pkgs.wooting-udev-rules];
}
