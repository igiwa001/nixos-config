{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.wootility];
}
