{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
    ../modules/systemd-boot.nix
    ../modules/networking.nix
    ../modules/common.nix
    ../modules/locale.nix
    ../modules/user.nix
    ../modules/pipewire.nix
    ../modules/keyring.nix
    ../modules/xdg-portal.nix
    ../modules/gdm.nix
    ../modules/hyprland.nix
  ];

  networking.hostName = "thinkpad-e14";
  system.stateVersion = "24.11";
}
