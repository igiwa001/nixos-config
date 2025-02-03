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
    ../modules/hardware/wooting.nix
    ../modules/system/systemd-boot.nix
    ../modules/system/bluetooth.nix
    ../modules/system/common.nix
    ../modules/system/locale.nix
    ../modules/system/user.nix
    ../modules/programs/pipewire.nix
    ../modules/programs/keyring.nix
    ../modules/programs/xdg-portal.nix
    ../modules/programs/gdm.nix
    ../modules/programs/hyprland.nix
    ../modules/applications/steam.nix
    ../modules/applications/thunar.nix
    ../modules/applications/noisetorch.nix
  ];

  # Correct scaling on xwayland apps
  environment.sessionVariables.GDK_SCALE = "1.5";

  networking.hostName = "desktop";
  system.stateVersion = "24.11";
}
