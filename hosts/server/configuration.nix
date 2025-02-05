{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # TODO: Hardware configuration
    ../modules/hardware/nvidia.nix
    ../modules/system/grub.nix
    ../modules/system/common.nix
    ../modules/system/locale.nix
    ../modules/system/user.nix
    ../modules/programs/pipewire.nix
    ../modules/programs/keyring.nix
    ../modules/services/ssh.nix
  ];

  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "server";
  system.stateVersion = "24.11";
}
