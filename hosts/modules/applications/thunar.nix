{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.thunar = {
    enable = true;
  };
}
