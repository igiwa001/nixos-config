{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.adb.enable = true;
  users.users.igorai.extraGroups = ["adbusers"];
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
  environment.systemPackages = [pkgs.android-tools];
  programs.nix-ld = {
    enable = true;
    libraries = [pkgs.android-tools];
  };
}
