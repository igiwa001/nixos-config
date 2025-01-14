{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.comment.enable = true;
}
