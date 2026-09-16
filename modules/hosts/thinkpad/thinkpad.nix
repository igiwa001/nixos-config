{inputs, ...}: let
  inherit (inputs.nixos-hardware.nixosModules) lenovo-thinkpad-e14-amd;
in {
  den.hosts.x86_64-linux.thinkpad.users.igorai = {};

  den.aspects.thinkpad.nixos = {
    imports = [
      ./_hardware-configuration.nix
      lenovo-thinkpad-e14-amd
    ];

    # Legacy
    settings = {
      system.stateVersion = "25.05";
      networking.hostname = "thinkpad";
      nixos.cores = 16;
    };
  };
}
