{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
}
