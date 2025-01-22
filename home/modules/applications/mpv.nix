{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.mpv = {
    enable = true;
  };
}
