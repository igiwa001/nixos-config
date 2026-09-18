{inputs, ...}: {
  den.hosts.x86_64-linux.thinkpad.users.igorai = {};

  den.aspects.thinkpad.nixos = {
    imports = [
      ./_hardware.nix
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
    ];
  };
}
