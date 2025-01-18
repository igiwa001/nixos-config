{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  time.timeZone = "Europe/Oslo";
  console.keyMap = "no";
  services.xserver.xkb.layout = "no";
}
