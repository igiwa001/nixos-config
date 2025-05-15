{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = false;
    })
  ];
}
