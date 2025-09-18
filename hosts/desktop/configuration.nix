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
    hardware.razer-nari.enable = true;
    programs.minecraft.enable = true;
    services.minecraft.enable = true;
  };
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0 power_save_controller=N
  '';
}
