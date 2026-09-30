{
  imports = [./minecraft-server.nix];

  settings = {
    system.stateVersion = "24.11";
    hardware.wooting.enable = true;
    programs.minecraft.enable = true;
    services.minecraft.enable = true;
    programs.lact.enable = true;
    services.factorio.enable = true;
  };
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xffffffff"];
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0 power_save_controller=N
  '';
}
