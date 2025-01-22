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
    ../modules/bluetooth.nix
    ../modules/common.nix
    ../modules/locale.nix
    ../modules/user.nix
    ../modules/pipewire.nix
    ../modules/keyring.nix
    ../modules/xdg-portal.nix
    ../modules/gdm.nix
    ../modules/hyprland.nix
    ../modules/steam.nix
    ../modules/thunar.nix
  ];

  # Correct scaling on xwayland apps
  environment.sessionVariables.GDK_SCALE = "1.5";

  networking.hostName = "thinkpad-e14";
  system.stateVersion = "24.11";
}
