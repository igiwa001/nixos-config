{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  users.users.igorai = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
  };
}
