{
  self,
  inputs,
  ...
}: let
  inherit
    (inputs.nixos-hardware.nixosModules)
    common-pc
    common-pc-ssd
    common-cpu-amd-pstate
    common-gpu-amd
    ;
in {
  den.hosts.x86_64-linux.desktop.users.igorai = {};

  den.aspects.desktop.nixos = {
    imports = [
      ./_hardware.nix
      "${self.outPath}/legacy/hosts/desktop/minecraft-server.nix" # Legacy
      common-pc
      common-pc-ssd
      common-cpu-amd-pstate
      common-gpu-amd
    ];

    # Legacy
    settings = {
      system.stateVersion = "24.11";
      networking.hostname = "desktop";
      nixos.cores = 24;
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
  };
}
