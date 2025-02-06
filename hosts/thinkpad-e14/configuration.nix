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
    ../modules/system/systemd-boot.nix
    ../modules/system/networking.nix
    ../modules/system/bluetooth.nix
    ../modules/system/common.nix
    ../modules/system/locale.nix
    ../modules/system/user.nix
    ../modules/programs/pipewire.nix
    ../modules/programs/keyring.nix
    ../modules/programs/xdg-portal.nix
    ../modules/programs/gdm.nix
    ../modules/programs/hyprland.nix
    ../modules/programs/podman.nix
    ../modules/applications/steam.nix
    ../modules/applications/thunar.nix
    ../modules/applications/noisetorch.nix
  ];

  # Correct scaling on xwayland apps
  environment.sessionVariables.GDK_SCALE = "1.5";

  networking.hostName = "thinkpad-e14";
  system.stateVersion = "24.11";
}
