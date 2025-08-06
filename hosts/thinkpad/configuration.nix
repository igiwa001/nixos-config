{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  settings = {
    system.stateVersion = "25.05";
    networking.hostname = "thinkpad";
    nixos.cores = 16;
  };
}
