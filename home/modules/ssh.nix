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
      "nix-server".hostname = "188.113.113.236";
    };
  };
}
