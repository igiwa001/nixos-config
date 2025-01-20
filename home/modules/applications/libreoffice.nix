{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.libreoffice
    pkgs.hunspell
    pkgs.hunspellDicts.en_US-large
    pkgs.hunspellDicts.pl_PL
    pkgs.hunspellDicts.nb_NO
  ];
}
