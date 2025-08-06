{...}: {
  imports = [./hardware-configuration.nix];

  settings = {
    system.stateVersion = "24.11";
    networking.hostname = "desktop";
    nixos.cores = 24;
    hardware.wooting = true;
    programs.lact.enable = true;
  };

  # Enable all AMDGPU features except GFXOFF
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xfffd7fff"];
}
