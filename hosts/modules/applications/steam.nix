{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
  environment = {
    systemPackages = [pkgs.mangohud];
    sessionVariables.MANGOHUD = 1;
  };
}
