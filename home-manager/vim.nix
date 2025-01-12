{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.vim = {
    enable = true;
    settings = {
      expandtab = true;
      copyindent = true;
      tabstop = 2;
      shiftwidth = 2;
      relativenumber = true;
    };
  };
}
