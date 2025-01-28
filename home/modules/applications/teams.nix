{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.teams-for-linux];
}
