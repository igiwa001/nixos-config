{inputs, ...}: let
  inherit
    (inputs.nixos-hardware.nixosModules)
    common-pc
    common-pc-ssd
    common-cpu-amd-pstate
    common-gpu-amd
    ;
in {
  imports = [
    ./hardware-configuration.nix
    common-pc
    common-pc-ssd
    common-cpu-amd-pstate
    common-gpu-amd
  ];

  settings = {
    system.stateVersion = "24.11";
    networking.hostname = "desktop";
    nixos.cores = 24;
    hardware.wooting.enable = true;
    programs.lact.enable = true;
  };

  # Enable all AMDGPU features except GFXOFF
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xfffd7fff"];
}
