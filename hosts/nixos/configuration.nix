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
    ../modules/xdg-portal.nix
    ../modules/gdm.nix
    ../modules/hyprland.nix
  ];

  networking.hostName = "nixos";
  system.stateVersion = "24.11";
}
