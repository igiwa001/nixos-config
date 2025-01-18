{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;
}
