{
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.server.users.igorai = {};

  den.aspects.server = {
    includes = [
      (den.aspects.system.bootloader.override {
        bootlader = "grub";
        device = "/dev/sda";
      })
    ];

    nixos.imports =
      [./_hardware.nix]
      ++ (with inputs.nixos-hardware.nixosModules; [
        common-pc
        common-cpu-intel-cpu-only
      ]);
  };
}
