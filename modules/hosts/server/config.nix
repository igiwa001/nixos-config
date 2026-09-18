{inputs, ...}: {
  den.hosts.x86_64-linux.server.users.igorai = {};

  den.aspects.server.nixos = {
    imports =
      [./_hardware.nix]
      ++ (with inputs.nixos-hardware.nixosModules; [
        common-pc
        common-cpu-intel-cpu-only
      ]);
  };
}
