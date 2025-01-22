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
    ../modules/nvidia.nix
    ../modules/systemd-boot.nix
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

  networking.hostName = "desktop";
  system.stateVersion = "24.11";
}
