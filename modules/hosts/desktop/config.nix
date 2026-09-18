{inputs, ...}: {
  den.hosts.x86_64-linux.desktop.users.igorai = {};

  den.aspects.desktop.nixos = {
    imports =
      [./_hardware.nix]
      ++ (with inputs.nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-amd-pstate
        common-gpu-amd
      ]);
  };
}
