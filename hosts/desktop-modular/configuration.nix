{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  settings = {
    system.stateVersion = "24.11";
    networking.hostname = "desktop-modular";
    nixos.cores = 24;
    hardware.wooting = true;
    programs.lact.enable = true;
  };

  # Enable all AMDGPU features except GFXOFF
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xfffd7fff"];

  # TEMPORARY
  settings.neovim.enable = false;
  settings.nvim-old.enable = true;
}
