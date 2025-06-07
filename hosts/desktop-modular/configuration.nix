{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  settings = {
    system.stateVersion = "24.11";
    networking.hostname = "desktop-modular";
    hardware.wooting = true;
  };
}
