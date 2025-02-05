{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "debian-server".hostname = "188.113.113.236";
    };
  };
  home = {
    shellAliases.wake-debian = "wakeonlan -i 188.113.113.236 -p 10000 f0:4d:a2:db:d4:bb";
    packages = [pkgs.wakeonlan];
  };
}
