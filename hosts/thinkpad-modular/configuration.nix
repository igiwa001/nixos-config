{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix ../../modules];

  networking.hostName = "thinkpad-modular";
  system.stateVersion = "24.11";
}
