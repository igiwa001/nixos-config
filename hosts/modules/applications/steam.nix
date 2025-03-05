{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extest.enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };
}
