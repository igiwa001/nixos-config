{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  settings = {
    system.stateVersion = "24.11";
    networking.hostname = "desktop-modular";
    nixos.cores = 24;
    hardware.wooting = true;
  };

  # AMDGPU crash workaround
  boot.kernelPackages = lib.mkForce (pkgs.linuxPackagesFor (pkgs.linuxKernel.kernels.linux_6_12.override {
    argsOverride = rec {
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
        sha256 = "b04c5b3e5df6e0aa5e9cd1efe527fac99f9dd39a43b97f13b22f8ca93e524ba7";
      };
      version = "6.12.31";
      modDirVersion = "6.12.31";
    };
  }));
}
