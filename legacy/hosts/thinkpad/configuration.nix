{inputs, ...}: let
  inherit (inputs.nixos-hardware.nixosModules) lenovo-thinkpad-e14-amd;
in {
  imports = [
    ./hardware-configuration.nix
    lenovo-thinkpad-e14-amd
  ];

  settings = {
    system.stateVersion = "25.05";
    networking.hostname = "thinkpad";
    nixos.cores = 16;
  };
}
