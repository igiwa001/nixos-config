{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings.indent.enable = true;
    };
  };
}
